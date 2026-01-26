-- PDF viewer inside Neovim
return {
  "nvim-lua/plenary.nvim",
  keys = {
    { "<leader>Po", desc = "Open PDF in buffer" },
    { "<leader>Pf", desc = "Find and open PDF" },
  },
  config = function()
    local function view_pdf(filepath)
      filepath = filepath or vim.fn.expand("%:p")

      if vim.fn.filereadable(filepath) == 0 then
        vim.notify("File not found: " .. filepath, vim.log.levels.ERROR)
        return
      end

      if not vim.fn.executable("pdftotext") then
        vim.notify("pdftotext not found. Install poppler: brew install poppler", vim.log.levels.ERROR)
        return
      end

      -- Convert PDF to text
      local output = vim.fn.system("pdftotext -layout '" .. filepath .. "' -")

      -- Create new buffer
      vim.cmd("enew")
      local buf = vim.api.nvim_get_current_buf()

      -- Set buffer options
      vim.bo[buf].buftype = "nofile"
      vim.bo[buf].bufhidden = "wipe"
      vim.bo[buf].swapfile = false
      vim.bo[buf].modifiable = true

      -- Insert content
      local lines = vim.split(output, "\n")
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      -- Set buffer name and make readonly
      vim.api.nvim_buf_set_name(buf, "PDF: " .. vim.fn.fnamemodify(filepath, ":t"))
      vim.bo[buf].modifiable = false
      vim.bo[buf].readonly = true

      vim.notify("Loaded: " .. vim.fn.fnamemodify(filepath, ":t"))
    end

    -- Commands
    vim.api.nvim_create_user_command("PDFView", function(opts)
      view_pdf(opts.args ~= "" and opts.args or nil)
    end, { nargs = "?", desc = "View PDF in buffer", complete = "file" })

    -- Keymaps
    vim.keymap.set("n", "<leader>Po", "<cmd>PDFView<cr>", { desc = "Open PDF in buffer" })
    vim.keymap.set("n", "<leader>Pf", function()
      local file = vim.fn.input("PDF file: ", "", "file")
      if file ~= "" then
        view_pdf(file)
      end
    end, { desc = "Find and open PDF" })

    -- Auto-view PDF files when opened
    vim.api.nvim_create_autocmd("BufReadCmd", {
      pattern = "*.pdf",
      callback = function(ev)
        view_pdf(ev.file)
      end,
    })
  end,
}
