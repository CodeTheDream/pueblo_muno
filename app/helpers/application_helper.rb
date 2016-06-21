module ApplicationHelper
  def total
    entree = Dish.price entree: params[:entree].to_s
    dessert = Dish.price dessert: params[:dessert].to_s
    drink = Dish.price drink: params[:drink].to_s
    entree + dessert + drink
  end

  def link_to_language(lang)
    if lang == 'English' && I18n.locale == :en
      output = <<-HTML.html_safe
        <img src="/en.png"></img> <span class="desktop-only">English</span>
      HTML
      link_to output, {lang: 'es'}, class: 'white no-decor'
    elsif lang == 'Español' && I18n.locale == :es
      output = <<-HTML.html_safe
        <img src="/es.png"></img> <span class="desktop-only">Español</span>
      HTML
      link_to output, {lang: 'en'}, class: 'white no-decor'
    end
  end

  def option_link(dish, hash)
    big_hash = {
      entree: params[:entree],
      dessert: params[:dessert],
      drink: params[:drink]
    }
    big_hash.merge!(hash)
    link_to dish[:name], big_hash, class: 'option'
  rescue TypeError, NoMethodError
    link_to dish, big_hash, class: 'option'
  end
end
