class PersonsController < ApplicationController
  def profile
    @ws_methods = WsMethod.all
  end
  def test
    id = params[:method_id]
    if id
      ws_method = WsMethod.find(id)
      exec_val = <<-WS_EOS
        begin
          ws_input_data = <<-WS_DATA
            #{ws_method.test_input}
          WS_DATA
          $stdin  = StringIO.new(ws_input_data)
          $stdout = StringIO.new
          #{ws_method.code}
          $stdout.string
        ensure
          $stdin  = STDIN
          $stdout = STDOUT
        end
      WS_EOS
      s = eval(exec_val)
      if s.gsub(/\s/,'') == ws_method.test_output.gsub(/\s/,'')
        s += "\nРезультаты тестового запуска совпали с ожидаемыми!"
      else
        s += "\n#{s.gsub(/\s/,'')}"
        s += "\n#{ws_method.test_output.gsub(/\s/,'')}"
        s += "\nРезультаты тестового запуска не совпали с ожидаемыми!"
      end
      s.gsub!(/\n/,"<br/>\n")
      render text: s
    else
      render text: "failure"
    end
  end
end
