const db = require('../database/db')
const addShop = async (req, res) => {
  let {name, slug} = req.body

  if (!name) {
    return res.status(400).json({error: 'Name is required'})
  }
  if (!slug) {
      return res.status(400).json({error: 'Slug is required'})
  }

  const query = `INSERT INTO shops (name,slug) VALUES (?,?);`
  try {
    const [result] = await db.execute(query, [name, slug])
    return res.status(201).json({message: 'shop created', user: {id: result.insertId, name, slug}})
  } catch (err) {
    if (err.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({error: 'shop already exists'})
    }
    console.error('Error creating shop:', err)
    return res.status(500).json({error: 'Internal server error'})
  }
}
const listShops = async (req, res) => {
  try {
    const query = `SELECT *
                   FROM shops;`
    const [result] = await db.execute(query)
    return res.status(200).json({message: 'Success', shops: result})
  } catch (e) {
    return res.status(500).json({error: 'Internal server error'})
  }
}
module.exports = {addShop, listShops}
