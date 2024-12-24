const express = require('express')
const userService = require('./service/userService')

const router = express.Router()

// POST /users API
router.post('/users', userService.addUser)

module.exports = router
