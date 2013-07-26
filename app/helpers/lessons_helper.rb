module LessonsHelper

  def skill_level_options(default_level = nil)
    options_for_select(%w(beginner low medium high expert).map{ |option| [t("lesson_form.levels.#{option}"), option] }, default_level)
  end

  def hours_options(default_duration = nil)
    options_for_select((0..12).map{|i| [t("lesson_form.hours", count: i), i]}, default_duration.try(:/, 60))
  end

  def minutes_options(default_duration = nil)
    options_for_select([0, 15, 30, 45].map{ |i| [t("lesson_form.minutes", count: i), i] }, default_duration.try(:%, 60))
  end

  def user_skill_list(user)
    user.skills.map{ |skill| t("sub_interests.#{skill.sub_interest.name}") }.join(', ')
  end

  def format_duration(duration)
    "#{t('lesson_form.duration')} #{duration / 60}:#{"%02d" % (duration % 60)}#{t('lesson.hours_short')}"
  end

  def interest_options(interests)
    options = interests.map do |interest|
      [t("interests.#{interest.name}"), interest.id]
    end
    options_for_select(options)
  end

  def sub_interest_options(interest)
    options = interest.sub_interests.map do |sub_interest|
      [t("sub_interests.#{sub_interest.name}"), sub_interest.id]
    end
    options_for_select(options)
  end

  def interests_as_json(interests)
    interests.inject({}) do |memo, interest|
      key = t("interests.#{interest.name}")
      memo[key] = interest.sub_interests.map do |sub_interest|
        [t("sub_interests.#{sub_interest.name}"), sub_interest.id]
      end

      memo[key].sort_by!{ |sub_interest| sub_interest[0].size }.reverse!
      memo
    end.to_json
  end

end
