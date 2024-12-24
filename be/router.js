const express = require('express')
const userService = require('./service/userService')
const rewardService = require('./service/rewardService')
const userRewardService = require('./service/userRewardService')
const codeService = require('./service/codeService')
const userCodeService = require('./service/userCodeService')

const router = express.Router()

//users API
// POST
router.post('/users', userService.addUser)

//rewards API
router.post('/rewards', rewardService.addReward)
router.get('/rewards', rewardService.listRewards)
router.patch('/rewards/:id', rewardService.updateReward)
router.delete('/rewards/:id', rewardService.deleteReward)
router.get('/rewards/:id', rewardService.getRewardById)

// user-reward API
router.post('/user-rewards', userRewardService.addUserReward);
router.get('/user-rewards/:id', userRewardService.getUserRewardById);
router.get('/user-rewards/user/:userId', userRewardService.getUserRewardsByUserId);
router.get('/user-rewards/reward/:rewardId', userRewardService.getUserRewardsByRewardId);

// codes API
router.post('/codes', codeService.addCode)
router.get('/codes', codeService.listCodes)
router.get('/codes/:id', codeService.getCodeById)
router.patch('/codes/:id', codeService.updateCode)
router.delete('/codes/:id', codeService.deleteCode)

router.post('/user-codes', userCodeService.addUserCode)
router.get('/user-codes', userCodeService.listUserCodes)
router.get('/user-codes/:id', userCodeService.getUserCodeById)
router.delete('/user-codes/:id', userCodeService.deleteUserCode)

module.exports = router
