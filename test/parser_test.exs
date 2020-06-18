defmodule ParserTest do
  use ExUnit.Case
  doctest Parser
  doctest Lexer

  setup_all do
    {:ok,
     tokens: [
       {%AST{
          left_node: %AST{
            left_node: %AST{
              left_node: nil,
              node_name: :constante,
              right_node: nil,
              value: 2
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion,
          right_node: nil,
          value: :main
        }, []}
     ],
     tokens_md: [
       {%AST{
          left_node: %AST{
            left_node: %AST{
              left_node: nil,
              node_name: :constante,
              right_node: nil,
              value: 100
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion,
          right_node: nil,
          value: :main
        }, []}
     ],
     tokens_0: [
       {%AST{
          left_node: %AST{
            left_node: %AST{
              left_node: nil,
              node_name: :constante,
              right_node: nil,
              value: 0
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion,
          right_node: nil,
          value: :main
        }, []}
     ],
     tokens_nz: [
       {%AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constante,
                right_node: nil,
                value: 0
              },
              node_name: :negacion_logica,
              right_node: nil,
              value: nil
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion,
          right_node: nil,
          value: :main
        }, []}
     ],
     tokens_nc: [
       {%AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constante,
                right_node: nil,
                value: 5
              },
              node_name: :negacion_logica,
              right_node: nil,
              value: nil
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion,
          right_node: nil,
          value: :main
        }, []}
     ],
     tokens_no: [
       {%AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 3
                },
                node_name: :negacion,
                right_node: nil,
                value: nil
              },
              node_name: :negacion_logica,
              right_node: nil,
              value: nil
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion,
          right_node: nil,
          value: :main
        }, []}
     ],
     tokens_no2: [
       {%AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 0
                },
                node_name: :complemento,
                right_node: nil,
                value: nil
              },
              node_name: :negacion,
              right_node: nil,
              value: nil
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion,
          right_node: nil,
          value: :main
        }, []}
     ],
     tokens_neg: [
       {%AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constante,
                right_node: nil,
                value: 5
              },
              node_name: :negacion,
              right_node: nil,
              value: nil
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion,
          right_node: nil,
          value: :main
        }, []}
     ],
     tokens_b0: [
       {%AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constante,
                right_node: nil,
                value: 0
              },
              node_name: :complemento,
              right_node: nil,
              value: nil
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion,
          right_node: nil,
          value: :main
        }, []}
     ],
     tokens_b: [
       {%AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constante,
                right_node: nil,
                value: 12
              },
              node_name: :negacion_logica,
              right_node: nil,
              value: nil
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion,
          right_node: nil,
          value: :main
        }, []}
     ],
      tokens_addsem3: [%AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constante,
                right_node: nil,
                value: 1
              },
              node_name: :suma,
              right_node: %AST{
                left_node: nil,
                node_name: :constante,
                right_node: nil,
                value: 2
              },
              value: nil
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion, 
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil, 
        value: nil
      }
      ],
      tokens_aso: [%AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 1
                },
                node_name: :resta,
                right_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 2 
                },
                value: nil
              },
              node_name: :resta,
              right_node: %AST{
                left_node: nil,
                node_name: :constante,
                right_node: nil,
                value: 3
              },
              value: nil
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: nil
      }
      ],
      tokens_aso2: [
        %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: %AST{
                    left_node: nil,
                    node_name: :constante,
                    right_node: nil,
                    value: 6
                  },
                  node_name: :division,
                  right_node: %AST{
                    left_node: nil,
                    node_name: :constante,
                    right_node: nil,
                    value: 3
                  },
                  value: nil
                },
                node_name: :division,
                right_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 2
                },
                value: nil
              },
              node_name: :return,
              right_node: nil,
              value: nil
            },
            node_name: :funcion,
            right_node: nil,
            value: :main
          },
          node_name: :program,
          right_node: nil,
          value: nil
        }
      ],
      tokens_div: [
        %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 4
                },
                node_name: :division,
                right_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 2
                },
                value: nil
              },
              node_name: :return,
              right_node: nil,
              value: nil
            },
            node_name: :funcion,
            right_node: nil,
            value: :main
          },
          node_name: :program,
          right_node: nil,
          value: nil
        }
      ],
      tokens_mult: [
        %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 2
                },
                node_name: :multiplicacion,
                right_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 3
                },
                value: nil
              },
              node_name: :return,
              right_node: nil,
              value: nil
            },
            node_name: :funcion,
            right_node: nil,
            value: :main
          },
          node_name: :program,
          right_node: nil,
          value: nil
        }
      ],
      tokens_parens: [
        %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 2
                },
                node_name: :multiplicacion,
                right_node: %AST{
                  left_node: %AST{
                    left_node: nil,
                    node_name: :constante,
                    right_node: nil,
                    value: 3
                  },
                  node_name: :suma,
                  right_node: %AST{
                    left_node: nil,
                    node_name: :constante,
                    right_node: nil,
                    value: 4
                  },
                  value: nil
                },
                value: nil
              },
              node_name: :return,
              right_node: nil,
              value: nil
            },
            node_name: :funcion,
            right_node: nil,
            value: :main
          },
          node_name: :program,
          right_node: nil,
          value: nil
        }
      ],

    tokens_precedence: [
      %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constante,
                right_node: nil,
                value: 2
              },
              node_name: :suma,
              right_node: %AST{
                left_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 3
                },
                node_name: :multiplicacion,
                right_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 4
                },
                value: nil
              },
              value: nil
            },
            node_name: :return,
            right_node: nil,
            value: nil
          },
          node_name: :funcion,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: nil
      }
      ],
      tokens_sub: [
        %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 1
                },
                node_name: :resta,
                right_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 2
                },
                value: nil
              },
              node_name: :return,
              right_node: nil,
              value: nil
            },
            node_name: :funcion,
            right_node: nil,
            value: :main
          },
          node_name: :program,
          right_node: nil,
          value: nil
        }
      ],
      tokens_subneg: [
        %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 2
                },
                node_name: :resta,
                right_node: %AST{
                  left_node: %AST{
                    left_node: nil,
                    node_name: :constante,
                    right_node: nil,
                    value: 1
                  },
                  node_name: :negacion,
                  right_node: nil,
                  value: nil
                },
                value: nil
              },
              node_name: :return,
              right_node: nil,
              value: nil
            },
            node_name: :funcion,
            right_node: nil,
            value: :main 
          },
          node_name: :program,
          right_node: nil,
          value: nil
        }
      ],
      tokens_unop_add: [
        %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: %AST{
                    left_node: nil,
                    node_name: :constante,
                    right_node: nil,
                    value: 2
                  },
                  node_name: :complemento,
                  right_node: nil,
                  value: nil
                },
                node_name: :suma,
                right_node: %AST{
                  left_node: nil,
                  node_name: :constante,
                  right_node: nil,
                  value: 3
                },
                value: nil
              },
              node_name: :return,
              right_node: nil, 
              value: nil
            },
            node_name: :funcion,
            right_node: nil,
            value: :main
          },
          node_name: :program,
          right_node: nil,
          value: nil
        }
      ],
      tokens_unopparens: [
        %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: %AST{
                    left_node: nil,
                    node_name: :constante,
                    right_node: nil,
                    value: 1
                  },
                  node_name: :suma,
                  right_node: %AST{
                    left_node: nil,
                    node_name: :constante,
                    right_node: nil,
                    value: 1
                  },
                  value: nil
                },
                node_name: :complemento,
                right_node: nil,
                value: nil
              },
              node_name: :return,
              right_node: nil,
              value: nil
            },
            node_name: :funcion,
            right_node: nil,
            value: :main
          },
          node_name: :program,
          right_node: nil,
          value: nil
        }
      ], 

      tokens_and_neg: [
      	%AST{
		  left_node: %AST{
		    left_node: %AST{
		      left_node: %AST{
		        left_node: %AST{
		          left_node: nil,
		          node_name: :constante,
		          right_node: nil,
		          value: 1
		        },
		        node_name: :logicalAnd,
		        right_node: %AST{
		          left_node: nil,
		          node_name: :constante,
		          right_node: nil,
		          value: 0
		        },
		        value: nil
		      },
		      node_name: :return,
		      right_node: nil,
		      value: nil
		    },
		    node_name: :funcion,
		    right_node: nil,
		    value: :main
		  },
		  node_name: :program,
		  right_node: nil,
		  value: nil
		}
      ], 

      tokens_and_true: [
      	%AST{
		  left_node: %AST{
		    left_node: %AST{
		      left_node: %AST{
		        left_node: %AST{
		          left_node: nil,
		          node_name: :constante,
		          right_node: nil,
		          value: 1
		        },
		        node_name: :logicalAnd,
		        right_node: %AST{
		          left_node: %AST{
		            left_node: nil,
		            node_name: :constante,
		            right_node: nil,
		            value: 1
		          },
		          node_name: :negacion,
		          right_node: nil,
		          value: nil
		        },
		        value: nil
		      },
		      node_name: :return,
		      right_node: nil,
		      value: nil
		    },
		    node_name: :funcion,
		    right_node: nil,
		    value: :main
		  },
		  node_name: :program,
		  right_node: nil,
		  value: nil 
		}
      ],

      tokens_eq_true: [
      	%AST{
		  left_node: %AST{
		    left_node: %AST{
		      left_node: %AST{
		        left_node: %AST{
		          left_node: nil,
		          node_name: :constante,
		          right_node: nil,
		          value: 1
		        },
		        node_name: :igual_a,
		        right_node: %AST{
		          left_node: nil,
		          node_name: :constante,
		          right_node: nil,
		          value: 1
		        },
		        value: nil
		      },
		      node_name: :return,
		      right_node: nil,
		      value: nil
		    },
		    node_name: :funcion,
		    right_node: nil,
		    value: :main
		  },
		  node_name: :program,
		  right_node: nil,
		  value: nil
		}
      ],

      tokens_eq_false: [
      	%AST{
    		  left_node: %AST{
    		    left_node: %AST{
    		      left_node: %AST{
    		        left_node: %AST{
    		          left_node: nil,
    		          node_name: :constante,
    		          right_node: nil,
    		          value: 1
    		        },
    		        node_name: :igual_a,
    		        right_node: %AST{
    		          left_node: nil,
    		          node_name: :constante,
    		          right_node: nil,
    		          value: 2
    		        },
    		        value: nil
    		      },
    		      node_name: :return,
    		      right_node: nil,
    		      value: nil
    		    },
    		    node_name: :funcion,
    		    right_node: nil,
    		    value: :main
    		  },
    		  node_name: :program,
    		  right_node: nil,
    		  value: nil
    		}
      ]
    }
  end

#Semana 1

  test " Retorna 2", state do
    expected_in =
      Lexer.lexer_principal([[1, "int "], [1, "main(){"], [2, "return "], [2, "2;"], [3, "}"]], [])

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == state[:tokens]
  end

  test " Solo espaciado", state do
    expected_in =
      Lexer.lexer_principal(
        [
          [1, "int "],
          [1, "main"],
          [1, "("],
          [1, ")"],
          [1, "{"],
          [1, "return "],
          [1, "2"],
          [1, ";"],
          [1, "}"]
        ],
        []
      )

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == state[:tokens]
  end

  test " Retorna 0", state do
    expected_in =
      Lexer.lexer_principal([[1, "int "], [1, "main(){"], [2, "return "], [2, "0;"], [3, "}"]], [])

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == state[:tokens_0]
  end

  test " Sin saltos de linea", state do
    expected_in =
      Lexer.lexer_principal([[1, "int "], [1, "main(){"], [1, "return "], [1, "2;"], [1, "}"]], [])

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == state[:tokens]
  end

#Errores Semana 1

  test " Falta punto y coma", _state do
    expected_in =
      Lexer.lexer_principal([[1, "int "], [1, "main(){"], [2, "2"], [2, ";"], [3, "}"]], [])

    parser_out = [Parser.analizador_gramatica(expected_in)]

	 assert parser_out == [{{:error, "Linea: 2. Error: se esperaba punto y coma."}}]
   
  end

  test " Faltan parentesis", _state do
    expected_in =
      Lexer.lexer_principal(
        [[1, "int "], [1, "main"], [1, "{"], [2, "return "], [2, "2;"], [3, "}"]],
        []
      )

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == [error: "Linea: 1. Error: se esparaba parentesis que abriera"]
  end

  test " Falta valor a retornar", _state do
    expected_in =
      Lexer.lexer_principal([[1, "int "], [1, "main(){"], [2, "return "], [2, ";"], [3, "}"]], [])

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == [error: "Linea: 1. Error: la funcion no devuelve nada"]
  end

  test " Falta cerrar parentesis", _state do
    expected_in =
      Lexer.lexer_principal(
        [[1, "int "], [1, "main("], [1, "{"], [2, "return "], [2, "2;"], [3, "}"]],
        []
      )

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == [error: "Linea: 1. Error: se esparaba parentesis que cerrara"]
  end

#Semana 2

  test " Diferente de cero", state do
    expected_in =
      Lexer.lexer_principal(
        [[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "!0;"], [3, "}"]],
        []
      )

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == state[:tokens_nz]
  end


  test " Nested ops", state do
    expected_in =
      Lexer.lexer_principal(
        [[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "!-3;"], [3, "}"]],
        []
      )

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == state[:tokens_no]
  end

  test " Negacion", state do
    expected_in =
      Lexer.lexer_principal(
        [[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "-5;"], [3, "}"]],
        []
      )

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == state[:tokens_neg]
  end

  test " Bitwise 0", state do
    expected_in =
      Lexer.lexer_principal(
        [[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "~0;"], [3, "}"]],
        []
      )

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == state[:tokens_b0]
  end

  test " Bitwise", state do
    expected_in =
      Lexer.lexer_principal(
        [[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "!12;"], [3, "}"]],
        []
      )

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == state[:tokens_b]
  end

#Errores semana 2

  test " Orden erroneo", _state do
    expected_in =
      Lexer.lexer_principal(
        [[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "4-;"], [3, "}"]],
        []
      )

    parser_out = [Parser.funcion_parser(expected_in)]   
	assert parser_out == [error: "Linea: 2. Error: Orden de operandos erroneos"]
  end

  test " Falta constante", _state do
    expected_in =
      Lexer.lexer_principal(
        [[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "!~;"], [3, "}"]],
        []
      )

    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == [error: "Linea: 1. Error: la funcion no devuelve nada"]
  end

  test " Falta constante 2", _state do
    expected_in =
      Lexer.lexer_principal(
        [[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "!;"], [3, "}"]],
        []
      )
    parser_out = [Parser.funcion_parser(expected_in)]
    assert parser_out == [error: "Linea: 1. Error: la funcion no devuelve nada"]
  end

#Semana 3

  test " Suma", state do
    expected_in =
      Lexer.lexer_principal(
        [[1, "int main() {"], [2, "    return 1 + 2;"], [3, "}"]],
        []
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == state[:tokens_addsem3]
  end

  test " Asociatividad", state do
    expected_in =
      Lexer.lexer_principal([[1, "int main() {"], [2, "    return 1 - 2 - 3;"], [3, "}"]],[]
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == state[:tokens_aso]    
  end

  test " Division", state do
    expected_in =
      Lexer.lexer_principal([[1, "int main() {"], [2, "    return 4 / 2;"], [3, "}"]],[]
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == state[:tokens_div]
  end

  test " Multiplicacion", state do
    expected_in =
      Lexer.lexer_principal([[1, "int main() {"], [2, "    return 2 * 3;"], [3, "}"]],[]
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == state[:tokens_mult]
  end

  test " Operaciones con parentesis", state do
    expected_in =
      Lexer.lexer_principal([[1, "int main() {"], [2, "    return 2 * (3 + 4);"], [3, "}"]],[]
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == state[:tokens_parens]
  end

  test " Precedencia", state do
    expected_in =
      Lexer.lexer_principal([[1, "int main() {"], [2, "    return 2 + 3 * 4;"], [3, "}"]],[]
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == state[:tokens_precedence]
  end

  test " Resta", state do
    expected_in =
      Lexer.lexer_principal([[1, "int main() {"], [2, "    return 1 - 2;"], [3, "}"]],[]
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == state[:tokens_sub]
  end

  test " Resta negada", state do
    expected_in =
      Lexer.lexer_principal([[1, "int main() {"], [2, "    return 2- -1;"], [3, "}"]],[]
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == state[:tokens_subneg]
  end

  test " Suma y complemento", state do
    expected_in =
      Lexer.lexer_principal([[1, "int main() {"], [2, "    return ~2 + 3;"], [3, "}"]],[]
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == state[:tokens_unop_add]
  end


#Errores Semana 3

  test " Parentesis mal formado", _state do
    expected_in =
      Lexer.lexer_principal([[1, "int main() {"], [2, "    return 2 (- 3);"], [3, "}"]],[]
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == [error: "Error: Los operandos no funcionan"]
  end

  test " Falta el primer operando", _state do
    expected_in =
      Lexer.lexer_principal([[1, "int main() {"], [2, "    return /3;"], [3, "}"]],[]
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == [error: "Error: Los operandos no funcionan"]
  end

  test " Falta el segundo operando", _state do
    expected_in =
      Lexer.lexer_principal([[1, "int main() {"], [2, "    return 1 + ;"], [3, "}"]],[]
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == [error: "Error: Los operandos no funcionan"]
  end


#Semana 4

  test " And falso sem 4", state do
  	expected_in = 
  	Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 && 0;"], [3, "}"]], []
  	)
  	parser_out = [Parser.programa_parser(expected_in)]
  	assert parser_out == state[:tokens_and_neg]
  end

  test " And verdadero sem 4", state do
  	expected_in = 
  		Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 && -1;"], [3, "}"]], []
  		)
	parser_out = [Parser.programa_parser(expected_in)]
	assert parser_out == state[:tokens_and_true]
  end

  test " Igual verdadero sem 4", state do
  	expected_in =
  	Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 == 1;"], [3, "}"]], []
  		)
  	parser_out = [Parser.programa_parser(expected_in)]
  	assert parser_out == state[:tokens_eq_true]
  end

  test " Falso igual sem 4", state do
  	expected_in = 
  	Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 == 2;"], [3, "}"]], []
  		)
  	parser_out = [Parser.programa_parser(expected_in)]
  	assert parser_out == state[:tokens_eq_false]
  end

  test " Falso mayor igual semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 >= 2;"], [3, "}"]], []
      )
    _parse_out = [Parser.programa_parser(expected_in)]
  end

  test " Verdadero mayor igual semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 >= 1;"], [3, "}"]], []
      )
    _parse_out = [Parser.programa_parser(expected_in)]
  end

  test " Falso mayor a semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 > 2;"], [3, "}"]], []
      )
    _parse_out = [Parser.programa_parser(expected_in)]
  end

  test " Verdadero mayor a semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 > 0;"], [3, "}"]], []
      )
    _parse_out = [Parser.programa_parser(expected_in)]
  end

  test " Falso menor igual a semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 <= -1;"], [3, "}"]], []
      )
    _parse_out = [Parser.programa_parser(expected_in)]
  end

  test " Verdadero menor igual a semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 0 <= 2;"], [3, "}"]], []
      )
    _parser_out = [Parser.programa_parser(expected_in)]
  end

  test " Falso menor a, semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 2 < 1;"], [3, "}"]], []
      )
    _parser_out = [Parser.programa_parser(expected_in)]
  end

  test " Verdadero menor a, semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 < 2;"], [3, "}"]], []
      )
    _parser_out = [Parser.programa_parser(expected_in)]
  end

  test " Falso Diferente de, semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 0 != 0;"], [3, "}"]], []
      )
    _parser_out = [Parser.programa_parser(expected_in)]
  end

  test " Verdadero Diferente de, semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return -1 != -2;"], [3, "}"]], []
      )
    _parser_out = [Parser.programa_parser(expected_in)]
  end

  test " Prescedencia semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 || 0 && 2;"], [3, "}"]], []
      )
    _parser_out = [Parser.programa_parser(expected_in)]
  end

  test " Prescedencia 2 semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return (1 || 0) && 0;"], [3, "}"]], []
      )
    _parser_out = [Parser.programa_parser(expected_in)]
  end

  test " Prescedencia 4 semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 2 == 2 || 0;"], [3, "}"]], []
      )
    _parser_out = [Parser.programa_parser(expected_in)]
  end

  test " Or Verdadero semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 || 0;"], [3, "}"]], []
      )
    _parser_out = [Parser.programa_parser(expected_in)]
  end

  test " Or Falso semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 0 || 0;"], [3, "}"]], []
      )
    _parser_out = [Parser.programa_parser(expected_in)]
  end


#Errores semana 4

  test " Falta primer operando semana 4", _state do
  	expected_in = 
  	Lexer.lexer_principal([[1, "int main() {"], [2, "return <= 2;"], [3, "}"]], []
  		)
  	parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == [error: "Error: Los operandos no funcionan"]
  end

  test " Falta operando de en medio semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 < > 3;"], [3, "}"]], []
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == [ error: "Error: Los operandos no funcionan"]
  end

  test " Falta punto y coma semana 4", _state do
    expected_in =
    Lexer.lexer_principal([[1, "int main() {"], [2, "return 1 || 2"], [3, "}"]], []
      )
    parser_out = [Parser.programa_parser(expected_in)]
    assert parser_out == [error: "Error: Los operandos no funcionan"]
  end

end