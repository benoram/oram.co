<template>
    <div class="min-h-screen bg-white">
        <navbar />
        <router-view />
    </div>
</template>

<script>

    import Navbar from './components/Navbar.vue'

    export default {
        components: {
            Navbar
        }
    }
</script>

<style>
</style>
