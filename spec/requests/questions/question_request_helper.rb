
def question_path_helper(path, show=false)
  question = create(:question)
  if show
    send(path, question)
  else
    send(path)
  end
end
