local status_companion, companion = pcall(require, "codecompanion")
if not status_companion then
  vim.notify("没有找到 codecompanion")
  return
end

companion.setup({
  adapters = {
    http = {
      dp_r1 = function()
        return require("codecompanion.adapters").extend("deepseek", {
          name = "deepseek_r1",
          url = "https://api.deepseek.com/chat/completions",
          env = {
            api_key = function()
              return os.getenv("DEEPSEEK_API_KEY")
            end,
          },
          schema = {
            model = {
              default = "deepseek-ai/DeepSeek-R1",
              choices = {
                ["deepseek-ai/DeepSeek-R1"] = { opts = { can_reason = true } },
                "deepseek-ai/DeepSeek-V3",
              },
            },
          },
        })
      end
    }
  },
  strategies = {
    chat = {
      adapter = 'deepseek', -- Use the name of your desired adapter
    },
    inline = {
      adapter = 'deepseek', -- Use the name of your desired adapter
    },

  },
  opts = {
    language = "Chinese",
  },

})
