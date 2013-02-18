module ApplicationHelper
  def print_date(date)
    # TODO: 当日なら時間だけ、当年なら月日だけ表示するようにしたい
    return date.strftime("%m/%d %H:%M")
  end
end
