Vim�UnDo� �y�����@?��e%�G��`�[C�����                                    b�    _�                        4    ����                                                                                                                                                                                                                                                                                                                                                             b��     �               E	 	local jsonls_opts = require("plugins.configs.lsp.settings.jsonls")5��       4                 :                    5�_�                       5    ����                                                                                                                                                                                                                                                                                                                                                             b��     �               K	 	local sumneko_opts = require("plugins.configs.lsp.settings.sumneko_lua")5��       5                 �                    5�_�                       ;    ����                                                                                                                                                                                                                                                                                                                                                             b��    �            	   !	 if server.name == "jsonls" then   D	 	local jsonls_opts = require("plugins.configs.lsp.servers.jsonls")   9	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)   	 end       &	 if server.name == "sumneko_lua" then   J	 	local sumneko_opts = require("plugins.configs.lsp.servers.sumneko_lua")   :	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)   	 end5��                      �      V      N      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        b�     �                5��                          7                     �                         8                     �                          7                     5�_�                             ����                                                                                                                                                                                                                                                                                                                                                  V        b�     �             �               %	if server.name == "sumneko_lua" then   I		local sumneko_opts = require("plugins.configs.lsp.servers.sumneko_lua")   9		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)   	end    5��                          8              �       5��