module ApplicationHelper
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
end
