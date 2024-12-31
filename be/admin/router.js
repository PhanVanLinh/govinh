const express = require('express')
const {getUsersWithCodesAndRewards, index, getCodes, getRewards, shops, newCodes} = require('./index')
const router = express.Router()
router.get('/shops/:shop', index)
router.get('/users', getUsersWithCodesAndRewards)
router.get('/codes', getCodes)
router.post('/codes', newCodes)
router.get('/rewards', getRewards)
router.get('/', shops)

module.exports = router
