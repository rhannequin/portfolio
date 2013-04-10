module PagesHelper

  def setMark(mark, under)
    str = ''
    i = j = 0
    until i >= mark  do
      str += '<img src="/img/check-icon.png" alt="Note : ' + i.to_s + '" width="16" height="16" />'
      i += 1
    end
    until j >= under - mark do
      str += '<img src="/img/check-icon-none.png" alt="Note : '  + j.to_s + '" width="16" height="16" />'
      j += 1
    end
    return str.html_safe
  end

end