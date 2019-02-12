class MarkdownController < ApplicationController
  before_action :set_navigation
  before_action :set_product
  before_action :set_document
  before_action :set_namespace

  def show
    redirect = Redirector.find(request)
    return redirect_to redirect if redirect

    @frontmatter = YAML.safe_load(document)

    raise Errno::ENOENT if @frontmatter['redirect']

    @document_title = @frontmatter['meta_title'] || @frontmatter['title']

    @content = MarkdownPipeline.new({
      code_language: @code_language,
      current_user: current_user,
    }).call(document)

    @custom_navigation = [
      {
        'title' => 'Introduction',
        'pages' => [
          {'title' => 'What are the Client SDKs?', 'url' => '#'},
          {'title' => 'Messaging', 'url' => '#'},
          {'title' => 'Voice', 'url' => '#'},
          {'title' => 'Video', 'url' => '#'},
        ]
      },
      {
        'title' => 'Getting Started',
        'pages' => [
          {'title' => 'Create a Nexmo account', 'url' => '#'},
          {'title' => 'Create a Nexmo application', 'url' => '#'},
          {'title' => 'Create test users', 'url' => '#'},
          {'title' => 'Add the Client SDK to your app', 'url' => '#'},
        ]
      },
      {
        'title' => 'Client SDK Basics',
        'pages' => [
          {'title' => 'The Conversation API', 'url' => '#'},
          {'title' => 'Nexmo CLI', 'url' => '#', 'label' => 'Optional'},
          {'title' => 'Authentication', 'url' => '#'},
          {'title' => 'User Management', 'url' => '#'}
        ]
      },
      {
        'title' => 'Developer Guides',
        'pages' => [
          {'title' => 'Push Notifications', 'url' => '#'},
          {'title' => 'The Conversation API', 'url' => '#'},
          {'title' => 'User Management', 'url' => '#'}
        ]
      }
    ]

    if !Rails.env.development? && @frontmatter['wip']
      @show_feedback = false
      render 'wip', layout: 'documentation'
    else
      render layout: 'documentation'
    end
  end

  def api
    redirect = Redirector.find(request)
    if redirect
      redirect_to redirect
    else
      render 'static/404', status: :not_found, formats: [:html]
    end
  end

  private

  def set_navigation
    @navigation = :documentation
  end

  def set_product
    @product = params[:product]
  end

  def set_document
    @document = params[:document]
  end

  def set_namespace
    if params[:namespace].present?
      @namespace_path = "app/views/#{params[:namespace]}"
      @namespace_root = 'app/views'
      @sidenav_root = "app/views/#{params[:namespace]}"
    else
      @namespace_path = "_documentation/#{@product}"
      @namespace_root = '_documentation'
      @sidenav_root = "#{Rails.root}/_documentation"
    end
  end

  def set_document_path_when_file_name_is_the_same_as_a_linkable_code_language
    path = "#{@namespace_path}/#{@document}/#{params[:code_language]}.md"
    return unless File.exist? path
    @document_path = path
    [params, request.parameters].each { |o| o.delete(:code_language) }
    @code_language = nil
  end

  def document
    set_document_path_when_file_name_is_the_same_as_a_linkable_code_language
    @document_path ||= "#{@namespace_path}/#{@document}.md"
    @document = File.read("#{Rails.root}/#{@document_path}")
  end
end
