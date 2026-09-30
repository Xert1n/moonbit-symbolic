/// 符号积分（基础规则，覆盖常见初等函数）
pub fn integrate(expr : Expr, var_name : String) -> Expr raise SymbolicError {
  match expr {
    // ∫ c dx = cx
    Constant(c) => Mul(Constant(c), Variable(var_name))
    // ∫ x dx = x^2 / 2
    Variable(name) => {
      if name == var_name {
        Div(Pow(Variable(var_name), Constant(2.0)), Constant(2.0))
      } else {
        Mul(Variable(name), Variable(var_name))
      }
    }
    // ∫ (u + v) dx = ∫u dx + ∫v dx
    Add(u, v) => Add(integrate(u, var_name), integrate(v, var_name))
    Sub(u, v) => Sub(integrate(u, var_name), integrate(v, var_name))
    // ∫ c * u dx = c * ∫u dx（常数提取）
    Mul(Constant(c), u) => Mul(Constant(c), integrate(u, var_name))
    // ∫ x^n dx = x^(n+1) / (n+1)
    Pow(Variable(name), Constant(n)) => {
      if name == var_name {
        Div(Pow(Variable(var_name), Constant(n + 1.0)), Constant(n + 1.0))
      } else {
        raise SymbolicError::UnsupportedIntegral(expr)
      }
    }
    // ∫ sin(x) dx = -cos(x)
    Sin(Variable(name)) => {
      if name == var_name {
        Neg(Cos(Variable(var_name)))
      } else {
        raise SymbolicError::UnsupportedIntegral(expr)
      }
    }
    // ∫ cos(x) dx = sin(x)
    Cos(Variable(name)) => {
      if name == var_name {
        Sin(Variable(var_name))
      } else {
        raise SymbolicError::UnsupportedIntegral(expr)
      }
    }
    // ∫ e^x dx = e^x
    Exp(Variable(name)) => {
      if name == var_name {
        Exp(Variable(var_name))
      } else {
        raise SymbolicError::UnsupportedIntegral(expr)
      }
    }
    _ => raise SymbolicError::UnsupportedIntegral(expr)
  }
}

pub suberror SymbolicError {
  UnsupportedIntegral(Expr)
  ParseError(String)
  UnsupportedOperation(String)
}

impl Show for SymbolicError {
  fn to_string(self : SymbolicError) -> String {
    match self {
      UnsupportedIntegral(e) => "Unsupported integral: \(e)"
      ParseError(msg) => "Parse error: \(msg)"
      UnsupportedOperation(op) => "Unsupported operation: \(op)"
    }
  }
}