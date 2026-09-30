/// 对表达式关于指定变量求导
pub fn differentiate(expr : Expr, var_name : String) -> Expr {
  match expr {
    // d/dx(c) = 0
    Constant(_) => Constant(0.0)
    // d/dx(x) = 1, d/dx(y) = 0
    Variable(name) => if name == var_name { Constant(1.0) } else { Constant(0.0) }

    // 乘积法则: (uv)' = u'v + uv'
    Mul(u, v) => {
      let du = differentiate(u, var_name)
      let dv = differentiate(v, var_name)
      Add(Mul(du, v), Mul(u, dv))
    }

    // 商法则: (u/v)' = (u'v - uv') / v^2
    Div(u, v) => {
      let du = differentiate(u, var_name)
      let dv = differentiate(v, var_name)
      Div(Sub(Mul(du, v), Mul(u, dv)), Pow(v, Constant(2.0)))
    }

    // 加法法则: (u+v)' = u' + v'
    Add(u, v) => Add(differentiate(u, var_name), differentiate(v, var_name))
    Sub(u, v) => Sub(differentiate(u, var_name), differentiate(v, var_name))

    // 链式法则: d/dx(f(g(x))) = f'(g(x)) * g'(x)
    Sin(u) => Mul(Cos(u), differentiate(u, var_name))
    Cos(u) => Mul(Neg(Sin(u)), differentiate(u, var_name))
    Tan(u) => Mul(Pow(Cos(u), Constant(-2.0)), differentiate(u, var_name))

    // 幂法则: d/dx(u^n) = n * u^(n-1) * u'
    Pow(base, Constant(n)) => {
      let du = differentiate(base, var_name)
      Mul(Mul(Constant(n), Pow(base, Constant(n - 1.0))), du)
    }

    // 一般幂法则（含变量指数）
    Pow(u, v) => {
      // u^v = e^(v * ln(u))
      differentiate(Exp(Mul(v, Log(u))), var_name)
    }

    // 指数法则: (e^u)' = e^u * u'
    Exp(u) => Mul(Exp(u), differentiate(u, var_name))

    // 对数法则: (ln u)' = u' / u
    Log(u) => Div(differentiate(u, var_name), u)

    Neg(u) => Neg(differentiate(u, var_name))
  }
}

/// 求导并化简
pub fn diff(expr : Expr, var_name : String) -> Expr {
  simplify(differentiate(expr, var_name))
}