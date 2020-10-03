import Vue from 'vue'
import Router from 'vue-router'
import Home from './../components/Home.vue'

Vue.use(Router)

const routes = [
    { path: '/', component: Home }
]

const router = new Router({
    routes
})

router.beforeResolve((to, from, next) => {
    next()
})

export default router