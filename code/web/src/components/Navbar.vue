<template>
    <nav class="bg-white border-b border-gray-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex">
                    <div class="flex-shrink-0 flex items-center sm:hidden">
                        <router-link to="/" aria-label="Site icon">
                            <img class="h-8 w-auto rounded-full" src="@/assets/images/ben-icon.svg" alt="Site icon, a rock climber">
                        </router-link>
                    </div>
                    <div class="hidden sm:-my-px sm:ml-6 space-x-8 sm:flex">
                       <router-link to="/" aria-label="Site icon, a rock climber" class="inline-flex items-center px-1 pt-1 border-b-2 border-indigo-500 text-sm font-medium leading-5 text-gray-900 focus:outline-none focus:border-indigo-700 transition duration-150 ease-in-out">
                            <img class="h-8 w-auto rounded-full" src="@/assets/images/ben-icon.svg" alt="Site icon">
                       </router-link>

                        <a href="https://github.com/benoram" class="inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm font-medium leading-5 text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-300 transition duration-150 ease-in-out">
                            GitHub
                        </a>

                        <a href="https://keybase.io/benoram/chat" class="inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm font-medium leading-5 text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-300 transition duration-150 ease-in-out">
                            Keybase
                        </a>

                        <a href="/documents/resume.pdf" class="inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm font-medium leading-5 text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-300 transition duration-150 ease-in-out">
                            Resume
                        </a>

                    </div>
                </div>

                <div class="-mr-2 flex items-center sm:hidden">
                    <button class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 focus:text-gray-500 transition duration-150 ease-in-out"
                            @click="isMenuOpen = !isMenuOpen">
                        <svg :class="isMenuOpen ? 'hidden' : 'block'"
                                class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                        </svg>
                        <svg :class="isMenuOpen ? 'block' : 'hidden'"
                                class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>

        <div :class="isMenuOpen ? 'block' : 'hidden'" class="sm:hidden">
            <div class="pt-2 pb-3 space-y-1">

                <a href="https://github.com/benoram" class="block pl-3 pr-4 py-2 border-l-4 border-transparent text-base font-medium text-gray-600 hover:text-gray-800 hover:bg-gray-50 hover:border-gray-300 focus:outline-none focus:text-gray-800 focus:bg-gray-50 focus:border-gray-300 transition duration-150 ease-in-out">
                    GitHub
                </a>

                <a href="https://keybase.io/benoram" class="block pl-3 pr-4 py-2 border-l-4 border-transparent text-base font-medium text-gray-600 hover:text-gray-800 hover:bg-gray-50 hover:border-gray-300 focus:outline-none focus:text-gray-800 focus:bg-gray-50 focus:border-gray-300 transition duration-150 ease-in-out">
                    Keybase
                </a>

                <a href="@/assets/files/resume.pdf" class="block pl-3 pr-4 py-2 border-l-4 border-transparent text-base font-medium text-gray-600 hover:text-gray-800 hover:bg-gray-50 hover:border-gray-300 focus:outline-none focus:text-gray-800 focus:bg-gray-50 focus:border-gray-300 transition duration-150 ease-in-out">
                    Resume
                </a>

            </div>
        </div>
    </nav>
</template>

<script>
    export default {
        components: {
        },
        data: () => ({
            isMenuOpen: false,
        }),
    }
</script>

<style>
</style>
