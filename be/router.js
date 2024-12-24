const express = require('express')
const userService = require('./service/userService')
const rewardService = require('./service/rewardService')
const userRewardService = require('./service/userRewardService')

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


module.exports = router
