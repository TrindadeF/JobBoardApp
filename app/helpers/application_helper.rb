module ApplicationHelper
    def dashboard_path_for(user)
      case user.user_type
      when 'academic'
        academic_root_path
      when 'recruiter'
        recruiter_root_path
      else
        root_path
      end
    end
  end
  