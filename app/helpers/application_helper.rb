module ApplicationHelper

  def fil_ariane(page, title, is_portfolio = false)
    fil = '<a href="/">Accueil</a>'
    if page != 'home'
      if is_portfolio
        if title == 'Portfolio'
          fil += ' - <a href="/portfolio">Portfolio</a>'
        else
          fil += ' - <a href="/portfolio">Portfolio</a> - ' + title
        end
      else
          fil += ' - ' + title
      end
    end
    return fil.html_safe;
  end

end
