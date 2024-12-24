const db = require('../database/db')
const {isValidPhoneNumber} = require('libphonenumber-js')

const addUser = async (req, res) => {
  const {phone, score} = req.body

  if (!phone || !score) {
    return res.status(400).json({error: 'Phone and score are required'})
  }
  if (!isValidPhoneNumber(phone, 'VN')) {
    return res.status(400).json({error: 'Invalid phone number'})
  }

  const query = `
      INSERT INTO users (phone, score)
      VALUES (?, ?);
  `

  try {
    const [result] = await db.execute(query, [phone, score])
    return res.status(201).json({message: 'User created', user: {id: result.insertId}})
  } catch (err) {
    if (err.code === 'ER_DUP_ENTRY') {
      const getQuery = `select score
                        from users
                        where phone = ?;`
      try {
        const [result] = await db.execute(getQuery, [phone])
        const currentScore = result[0]?.score || 0
        const updateScore = currentScore + score
        const updateQuery = `UPDATE users
                             SET score = ?
                             WHERE phone = ?;`
        try {
          await db.execute(updateQuery, [updateScore, phone])
          return res.status(201).json({message: 'User updated'})
        } catch (err) {
          return res.status(500).json({error: 'Internal server error'})
        }
      } catch (error) {
        console.error(error)
      }
    }
    console.error('Error creating user:', err)
    return res.status(500).json({error: 'Internal server error'})
  }
}

module.exports = {addUser}
