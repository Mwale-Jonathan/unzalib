/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ["./src/**/*.{html,js,py}", "./src/**/**/*.{html,js,py}", "node_modules/preline/dist/*.js"],
    theme: {
        extend: {
            fontFamily: {
                rubik: ["Rubik", "sans-serif"],
                concert: ["Concert One", "sans-serif"],
            },
            colors: {
                "primary": "#346cb0"
            },
        },
    },
    plugins: [require("@tailwindcss/forms"), require("preline/plugin")],
    darkMode: "class",
};
