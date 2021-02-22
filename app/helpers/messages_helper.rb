module MessagesHelper
  def authorize_messages(conversation)
    conversation.sender == current_user || conversation.recipient == current_user
  end

  def shorten_filename(filename)
    file = filename.to_s.squish
    extension = file.split('.')[-1]
    if file.length > 5
      file[0..4].concat(".#{extension}")
    else
      file[0..file.length].concat(".#{extension}")
    end
  end
end
