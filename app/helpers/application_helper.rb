module ApplicationHelper
  def link_to_language(lang)
    options = food_options
    if lang == 'English' && I18n.locale == :en
      output = <<-HTML.html_safe
        <img src="/es.png"></img> <span class="desktop-only">Haz click aqui para Espanol</span>
      HTML
      options.merge!(lang: 'es')
      link_to output, options, class: 'white no-decor'
    elsif lang == 'Español' && I18n.locale == :es
      output = <<-HTML.html_safe
        <img src="/en.png"></img> <span class="desktop-only">Click here for English version</span>
      HTML
      options.merge!(lang: 'en')
      link_to output, options, class: 'white no-decor'
    end
  end

  def option_link(dish, hash)
    options = food_options
    options.merge!(hash)
    link_to t(".#{dish[:name]}"), options, class: 'option button-secondary'
  rescue TypeError, NoMethodError
    link_to dish, options, class: 'option button-secondary'
  end

  def people(votes)
    votes.count
  end

  def total
    entree = Dish.price entree: params[:entree].to_s
    dessert = Dish.price dessert: params[:dessert].to_s
    drink = Dish.price drink: params[:drink].to_s
    entree + dessert + drink
  end

  def total_class
    case total
    when 0 then "grayback"
    when 1..100 then "greenback"
    else "redback"
    end
  end

  def votes(votes)
    count = 0
    votes.each do |vote|
      count += 1 if vote.entree
      count += 1 if vote.dessert
      count += 1 if vote.drink
    end
    count
  end

  def food_options
    {
      entree: params[:entree],
      dessert: params[:dessert],
      drink: params[:drink]
    }
  end
end
