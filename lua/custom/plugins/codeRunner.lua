return {
  {
    'CRAG666/code_runner.nvim',
    config = function()
      require('code_runner').setup {
        filetype = {
          cpp = {
            'cd $dir &&',
            'g++ $fileName -o $fileNameWithoutExt &&',
            -- Use .\\ for Windows execution
            '.\\$fileNameWithoutExt',
          },
          python = 'python -u',
        },
      }
    end,
  },
}
