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

  def lesson_buyable?(lesson)
    # not a teacher && user not applied && lesson has places && lesson not passed
    lesson.teacher != current_user && !lesson.user_already_applied?(current_user) && lesson.available? && !lesson.passed?
  end

end
