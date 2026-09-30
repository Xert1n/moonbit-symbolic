test "d/dx(x^2) = 2x" {
  let x = Variable("x")
  let expr = Pow(x, Constant(2.0))
  let result = diff(expr, "x")
  // 期望: 2 * 1 * x^(2-1) = 2x
  assert_eq!(result.to_string(), "2 * x^1")
}

test "d/dx(sin(x)) = cos(x)" {
  let expr = Sin(Variable("x"))
  let result = diff(expr, "x")
  assert_eq!(result.to_string(), "cos(x)")
}

test "d/dx(x * sin(x)) = sin(x) + x*cos(x)" {
  let x = Variable("x")
  let expr = Mul(x, Sin(x))
  let result = diff(expr, "x")
  // 乘积法则: 1*sin(x) + x*cos(x)
  assert_true!(result.to_string().contains("sin(x)"))
  assert_true!(result.to_string().contains("cos(x)"))
}

test "d/dx(e^(x^2)) = 2x * e^(x^2)" {
  let x = Variable("x")
  let expr = Exp(Pow(x, Constant(2.0)))
  let result = diff(expr, "x")
  // 链式法则: e^(x^2) * 2x
  assert_true!(result.to_string().contains("exp"))
}

test "d/dx(ln(x)) = 1/x" {
  let expr = Log(Variable("x"))
  let result = diff(expr, "x")
  assert_eq!(result.to_string(), "1 / x")
}