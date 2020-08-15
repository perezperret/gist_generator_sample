require 'gist_generator'

Handler = proc do |req, res|
  repo_path = req.query['repo_path']
  file_path = req.query['file_path']
  line_numbers = req.query['line_numbers']&.split(/\s*,\s*/)&.map(&:to_i)

  unless repo_path && file_path
    res.status = 402
    res.body = 'Repo path, file path and line numbers are required'
    next
  end

  gists = GistGenerator::Generator.call \
    repo_path: repo_path,
    gists: [
      { file_path: file_path, line_numbers: line_numbers }
    ]

  gist_text = GistGenerator::Serializers::Pretty.call(gists).first.join

  res.status = 200
  res['Content-Type'] = 'text/text; charset=utf-8'
  res.body = gist_text
end
