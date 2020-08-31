const launchConfig = {
    // headless <boolean> Whether to run browser in headless mode,
    // false means not testing without launching up browser.
    headless: true,
    // Whether to auto-open a DevTools panel for each tab. If this option is true,
    // the headless option will be set false.
    // devtools: true,
    // Slows down Puppeteer operations by the specified amount of milliseconds.
    // Useful so that you can see what is going on.
    // Sets a consistent viewport for each page.
    // Defaults to an 800x600 viewport. null disables the default viewport.
    defaultViewport: null,
}

module.exports = {launchConfig}