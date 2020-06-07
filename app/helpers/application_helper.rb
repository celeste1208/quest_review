module ApplicationHelper
  def opinion(type)
    case type
    when 'positive'
      '良かった点'
    when 'negative'
      '改善点'
    when 'question'
      '質問・その他'
    end
  end
end
