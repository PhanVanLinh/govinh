const db = require('../database/db')

const generateRandomCode = (length) => {
  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  let code = ''
  for (let i = 0; i < length; i++) {
    code += characters.charAt(Math.floor(Math.random() * characters.length))
  }
  return code
}

const addCode = async (shop_id, count = 50) => {
  if (!shop_id) {
    throw new Error('Shop ID is required')
  }

  const queryShop = `SELECT *
                     FROM shops
                     WHERE id = ?`
  const [resultShop] = await db.execute(queryShop, [shop_id])
  if (resultShop.length === 0) {
    throw new Error('Shop not found')
  }

  const codes = []
  for (let i = 1; i <= count; i++) {
    const code = generateRandomCode(Math.floor(Math.random() * (8 - 5 + 1)) + 5)
    const point = i % 10 === 0 ? 20 : 10
    codes.push([code, point, shop_id])
  }

  const query = `INSERT INTO codes (code, point, shop_id)
                 VALUES ?`
  await db.query(query, [codes])

  return codes.map(([code, point]) => ({code, point, is_used: false}))
};


const addCodeAPI = async (req, res) => {
  const {shop_id} = req.body

  if (!shop_id) {
    return res.status(400).json({error: 'Shop ID is required'})
  }

  try {
    const generatedCodes = await addCode(shop_id)
    return res.status(201).json({
      message: 'Codes created successfully',
      generatedCodes,
    })
  } catch (err) {
    if (err.message === 'Shop not found') {
      return res.status(404).json({error: err.message})
    }
    if (err.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({error: 'One or more codes already exist'})
    }
    console.error(err)
    return res.status(500).json({error: 'Internal server error', details: err.message})
  }
};

const listCodes = async (req, res) => {
  const {key, start, end, shop} = req.query

  const API_KEY = process.env.API_KEY
  if (key !== API_KEY) {
    return res.status(403).json({error: 'Invalid API key'})
  }

  if (!start || !end || isNaN(start) || isNaN(end) || start >= end) {
    return res.status(400).json({error: 'Invalid start or end range'})
  }

  if (!shop) {
    return res.status(400).json({error: 'shop_id is required'})
  }

  const startId = parseInt(start)
  const endId = parseInt(end)
  const rangeSize = endId - startId + 1

  const query = `SELECT *
                 FROM codes
                 WHERE id >= ?
                   AND id <= ?
                   AND is_used = false
                   AND shop_id = ?`
  try {
    const [codes] = await db.execute(query, [startId, endId, shop])

    if (codes.length < rangeSize) {
      const neededCodes = rangeSize - codes.length
      console.log(`Generating ${neededCodes} additional codes.`)
      await addCode(shop, neededCodes) // Call the reusable `addCode` function
    }

    const [updatedCodes] = await db.execute(query, [startId, endId, shop])

    return res.status(200).json({
      message: 'Success',
      codes: updatedCodes,
    })
  } catch (err) {
    console.error(err)
    return res.status(500).json({error: 'Internal server error', details: err.message})
  }
};


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
  addCodeAPI
}
