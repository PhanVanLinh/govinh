const db = require('../database/db')

const addReward = async (req, res) => {
  const {name, value} = req.body
  if (!name || !value) return res.status(400).json({error: 'name or value are required'})
  const query = `INSERT INTO rewards (name, value)
                 VALUES (?, ?);`
  try {
    const [result] = await db.execute(query, [name, value])
    return res.status(201).json({message: 'Reward created', reward: {id: result.insertId, name: name, value: value}})
  } catch (e) {
    if (e.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({error: 'Reward already exists'})
    }
    return res.status(500).json({error: 'Internal server error'})
  }

}

const listRewards = async (req, res) => {
  const query = `SELECT *
                 FROM rewards;`
  try {
    const [result] = await db.execute(query)
    console.log(result)
    return res.status(200).json({message: 'Success', rewards: result})
  } catch (e) {
    return res.status(500).json({error: 'Internal server error'})
  }

}

const updateReward = async (req, res) => {
  const {name, value} = req.body
  const {id} = req.params

  if (!name && !value) {
    return res.status(400).json({error: 'Name or value are required'})
  }

  let query = ''
  const params = []

  if (name && value) {
    query = `UPDATE rewards
             SET name  = ?,
                 value = ?
             WHERE id = ?`
    params.push(name, value, id)
  } else if (value) {
    query = `UPDATE rewards
             SET value = ?
             WHERE id = ?`
    params.push(value, id)
  } else {
    query = `UPDATE rewards
             SET name = ?
             WHERE id = ?`
    params.push(name, id)
  }

  try {
    const [result] = await db.execute(query, params)

    if (result.affectedRows === 0) {
      return res.status(404).json({error: 'Reward not found'})
    }
    console.log(result)
    return res.status(200).json({message: 'Success'})
  } catch (e) {
    if (e.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({error: 'Reward already exists'})
    }
    console.error('Error updating:', e)
    return res.status(500).json({error: 'Internal server error'})
  }
}

const deleteReward = async (req, res) => {
  const {id} = req.params

  if (!id) {
    return res.status(400).json({error: 'Reward ID is required'})
  }

  const deleteQuery = `DELETE
                       FROM rewards
                       WHERE id = ?`
  const checkExistenceQuery = `SELECT *
                               FROM rewards
                               WHERE id = ?`

  try {
    const [existingReward] = await db.execute(checkExistenceQuery, [id])
    if (existingReward.length === 0) {
      return res.status(404).json({error: 'Reward not found'})
    }

    await db.execute(deleteQuery, [id])
    return res.status(200).json({message: 'Reward deleted successfully'})
  } catch (e) {
    console.error('Error deleting reward:', e)
    return res.status(500).json({error: 'Internal server error'})
  }
}

const getRewardById = async (req, res) => {
  const {id} = req.params

  if (!id) {
    return res.status(400).json({error: 'Reward ID is required'})
  }

  const query = `SELECT *
                 FROM rewards
                 WHERE id = ?`

  try {
    const [result] = await db.execute(query, [id])
    if (result.length === 0) {
      return res.status(404).json({error: 'Reward not found'})
    }

    return res.status(200).json({message: 'Success', reward: result[0]})
  } catch (e) {
    console.error('Error retrieving reward:', e)
    return res.status(500).json({error: 'Internal server error'})
  }
}

module.exports = {addReward, listRewards, updateReward, deleteReward, getRewardById}