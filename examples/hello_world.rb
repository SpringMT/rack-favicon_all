class HelloWorld
  def call(env)
    [200, {"Content-Type" => "text/html"}, [%Q{<html><head><link href="/favicon.ico" rel="shortcut icon" /></head><body>hello</body></html>}]]
  end
end

