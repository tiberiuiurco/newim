return {
	  "tamago324/lir.nvim",
	"kyazdani42/nvim-web-devicons",
	  "tamago324/lir-git-status.nvim",
	
	  {
	    "tamago324/lir-mmv.nvim",
	    cond = function()
	      return vim.fn.executable "mmv" == 1
	    end,
	  },
}
