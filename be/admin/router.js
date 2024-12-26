const express = require('express')
const {getUsersWithCodesAndRewards} = require('./index')
const router = express.Router()

router.get('/users-with-details', getUsersWithCodesAndRewards)

module.exports = router
