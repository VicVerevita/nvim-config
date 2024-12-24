return {
    "Facel3ss1/subway-surfers.nvim",
    cmd = { "SubwaySurfers" },
    config = function()
        require("subway-surfers").setup()
    end,
    run = ":SubwaySurfers download",
}
