module ApplicationHelper
  def connection_helper(num_str)
    t "pages.start.c#{num_str}"
  end

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
        <img src="/es.png"></img> <span class="desktop-only">Click para Español</span>
      HTML
      options.merge!(lang: 'es')
      link_to output, options, class: 'no-decor'
    elsif lang == 'Español' && I18n.locale == :es
      output = <<-HTML.html_safe
        <img src="/en.png"></img> <span class="desktop-only">Click for English</span>
      HTML
      options.merge!(lang: 'en')
      link_to output, options
    end
  end

  def more_information(text)
    <<-HTML.html_safe
      <span class="info">#{text}</span>
    HTML
  end

  def option_link(dish, hash, price: nil, selected: false, info: nil)
    options = food_options
    options.merge!(hash)
    dish_name = t dish
    info = more_information info
    text = price ? "#{dish_name}: $#{price}" : dish_name
    if selected
      text = '<i class="fa fa-minus" aria-hidden="true"></i> ' + text
    else
      text = '<i class="fa fa-plus" aria-hidden="true"></i> ' + text
    end

    classes = dish_background dish
    classes << "selected" if selected

    link = link_to text.html_safe, options, class: classes.join(' ')

    info_btn = <<-HTML
      <div class="icon-container">
        <div class="info-btn">
            <i class="fa fa-question-circle-o fa-lg front" aria-hidden="true"></i>
            <i class="fa fa-times-circle fa-lg back" aria-hidden="true"></i>
        </div>
      </div>
    HTML

    <<-HTML.html_safe
      <div class="option">
        <div class="flex-container justify-between dish-header">
          #{link}#{info_btn}
        </div>
        #{info}
      </div>
    HTML
  end

  def dish_background(dish)
    hash = {
      "policy" => "bg-red",
      "growth" => "bg-blk",
      "growth_action" => "bg-blu",
      "referrals" => "bg-grn",
      "diversity" => "bg-prp",
      "raleigh" => "bg-red",
      "wake" => "bg-prp",
      "wake_and_more" => "bg-org",
      "statewide" => "bg-grn",
      "federal" => "bg-blu"
    }
    [hash[dish]]
  end

  def people(votes)
    votes.count
  end

  def total(vote = nil)
    if vote
      entree = Dish.price entree: vote.entree
      dessert = Dish.price dessert: vote.dessert
      drink = Dish.price drink: vote.drink
    else
      entree = Dish.price entree: params[:entree].to_s
      dessert = Dish.price dessert: params[:dessert].to_s
      drink = Dish.price drink: params[:drink].to_s
    end
    entree + dessert + drink
  end

  def total_class
    case 100 - total
    when 0..100 then "greenback"
    else "redback"
    end
  end

  def total_header
    s = total
    a = 100 - s
    balance = I18n.locale == :en ? "AVAILABLE: $#{a} SPENT: $#{s}" : "DISPONIBLE: $#{a} GASTADO: $#{s}"
    # balance = I18n.locale == :en ? 'LEFT TO SPEND' : 'SALDO'
    <<-HTML.html_safe
      <div id="total" class="flex-container white xy-center #{total_class}">#{balance}</div>
    HTML
  end

  def user(vote)
    if vote.user.name.present? && vote.user.email.present?
      mail_to vote.user.email, vote.user.name, class: 'user'
    elsif vote.user.email.present?
      mail_to vote.user.email, vote.user.email, class: 'user'
    elsif vote.user.name.present?
      "<span class='user-bl'>#{vote.user.name}</span>".html_safe
    else
      '<span class="user-bl">Anonymous</span>'.html_safe
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
