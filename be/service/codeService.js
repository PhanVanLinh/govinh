const db = require('../database/db')

const addCode = async (req, res) => {
  const {code, point} = req.body

  if (!code || !point) {
    return res.status(400).json({error: 'Code and point are required'})
  }

  const query = `INSERT INTO codes (code, point)
                 VALUES (?, ?)`
  try {
    const [result] = await db.execute(query, [code, point])
    return res.status(201).json({
      message: 'Code created',
      code: {id: result.insertId, code, point, is_used: false},
    })
  } catch (err) {
    if (err.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({error: 'Code already exists'})
    }
    return res.status(500).json({error: 'Internal server error'})
  }
}

const listCodes = async (req, res) => {
  const query = `SELECT *
                 FROM codes`

  try {
    const [codes] = await db.execute(query)

    return res.status(200).json({
      message: 'Success',
      codes,
    })
  } catch (err) {
    return res.status(500).json({error: 'Internal server error'})
  }
}

const updateCode = async (req, res) => {
  const {id} = req.params
  const {code, point, is_used} = req.body

  if (!code && !point && is_used === undefined) {
    return res.status(400).json({error: 'Nothing to update'})
  }

  const fields = []
  const values = []

  if (code) {
    fields.push('code = ?')
    values.push(code)
  }
  if (point) {
    fields.push('point = ?')
    values.push(point)
  }
  if (is_used !== undefined) {
    fields.push('is_used = ?')
    values.push(is_used)
  }

  values.push(id)

  const query = `UPDATE codes
                 SET ${fields.join(', ')}
                 WHERE id = ?`

  try {
    const [result] = await db.execute(query, values)
    if (result.affectedRows === 0) {
      return res.status(404).json({error: 'Code not found'})
    }
    return res.status(200).json({message: 'Code updated'})
  } catch (err) {
    return res.status(500).json({error: 'Internal server error'})
  }
}

const deleteCode = async (req, res) => {
  const {id} = req.params

  const query = `DELETE
                 FROM codes
                 WHERE id = ?`
  try {
    const [result] = await db.execute(query, [id])
    if (result.affectedRows === 0) {
      return res.status(404).json({error: 'Code not found'})
    }
    return res.status(200).json({message: 'Code deleted'})
  } catch (err) {
    return res.status(500).json({error: 'Internal server error'})
  }
}

const getCodeById = async (req, res) => {
  const {id} = req.params

  let query = `SELECT *
               FROM codes
               WHERE id = ?`
  try {
    const [result] = await db.execute(query, [id])
    if (result.length === 0) {
      query = `SELECT *
               FROM codes
               WHERE code = ?`
      const [resultCode] = await db.execute(query, [id])
      if (resultCode.affectedRows > 0) {
        return res.status(200).json({message: 'Success', code: resultCode[0]})
      }
      return res.status(404).json({error: 'Code not found'})
    }
    return res.status(200).json({message: 'Success', code: result[0]})
  } catch (err) {
    return res.status(500).json({error: 'Internal server error'})
  }
}

module.exports = {
  addCode,
  listCodes,
  updateCode,
  deleteCode,
  getCodeById,
}
