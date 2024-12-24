const db = require('../database/db')

const addUserReward = async (req, res) => {
  const {userId, rewardId} = req.body
  if (!userId || !rewardId) {
    return res.status(400).json({error: 'rewardId or userId are required'})
  }

  const query = `INSERT INTO user_reward (user_id, reward_id)
                 VALUES (?, ?);`

  try {
    const userQuery = `SELECT current_score
                       FROM users
                       WHERE id = ?`
    const [userResult] = await db.execute(userQuery, [userId])
    if (userResult.length === 0) {
      return res.status(404).json({error: 'User not found'})
    }

    const rewardQuery = `SELECT value
                         FROM rewards
                         WHERE id = ?`
    const [rewardResult] = await db.execute(rewardQuery, [rewardId])
    if (rewardResult.length === 0) {
      return res.status(404).json({error: 'Reward not found'})
    }
    let currentScore = userResult[0].current_score
    let rewardValue = rewardResult[0].value
    if (currentScore < rewardValue) {
      return res.status(400).json({error: 'Not enough current score'})
    }

    const [insertResult] = await db.execute(query, [userId, rewardId])
    let updateScore = currentScore - rewardValue
    const updateCurrentScoreQuery = `UPDATE users SET current_score = ? WHERE id = ?`
    await db.execute(updateCurrentScoreQuery, [updateScore, userId])
    return res.status(201).json({
      message: 'Created',
      reward: {id: insertResult.insertId, rewardId, userId, remainingScore: updateScore},
    })
  } catch (e) {
    if (e.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({error: 'User-Reward already exists'})
    }
    return res.status(500).json({error: 'Internal server error'})
  }
}


const getUserRewardById = async (req, res) => {
  const {id} = req.params
  if (!id) {
    return res.status(400).json({error: 'Reward ID is required'})
  }

  const query = `SELECT *
                 FROM user_reward
                 WHERE id = ?`

  try {
    const [result] = await db.execute(query, [id])
    if (result.length === 0) {
      return res.status(404).json({error: 'User-Reward not found'})
    }
    return res.status(200).json({message: 'Success', userReward: result[0]})
  } catch (e) {
    return res.status(500).json({error: 'Internal server error'})
  }
}

const getUserRewardsByUserId = async (req, res) => {
  const {userId} = req.params
  if (!userId) {
    return res.status(400).json({error: 'User ID is required'})
  }

  const query = `SELECT *
                 FROM user_reward
                 WHERE user_id = ?`

  try {
    const [result] = await db.execute(query, [userId])
    if (result.length === 0) {
      return res.status(404).json({error: 'No rewards found for this user'})
    }
    return res.status(200).json({message: 'Success', userRewards: result})
  } catch (e) {
    return res.status(500).json({error: 'Internal server error'})
  }
}

const getUserRewardsByRewardId = async (req, res) => {
  const {rewardId} = req.params
  if (!rewardId) {
    return res.status(400).json({error: 'Reward ID is required'})
  }

  const query = `SELECT *
                 FROM user_reward
                 WHERE reward_id = ?`

  try {
    const [result] = await db.execute(query, [rewardId])
    if (result.length === 0) {
      return res.status(404).json({error: 'No users found for this reward'})
    }
    return res.status(200).json({message: 'Success', userRewards: result})
  } catch (e) {
    return res.status(500).json({error: 'Internal server error'})
  }
}

module.exports = {
  addUserReward,
  getUserRewardById,
  getUserRewardsByUserId,
  getUserRewardsByRewardId,
}
