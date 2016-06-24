module ApplicationHelper
  def food_options
    {
      entree: params[:entree],
      dessert: params[:dessert],
      drink: params[:drink]
    }
  end

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

  def more_information(text)
    <<-HTML.html_safe
      <span class="option" style="display:none;">#{text}</span>
    HTML
  end

  def option_link(dish, hash, price: nil)
    options = food_options
    options.merge!(hash)
    dish = t("#{dish}")
    if price
      text = <<-HTML.html_safe
      #{dish}: $#{price} <span>?</span>
      HTML

      link_to text, options, class: 'option'
    else
      text = <<-HTML.html_safe
      #{dish} <span>?</span>
      HTML
      link_to text, options, class: 'option'
    end
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
end
