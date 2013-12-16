augroup rubyfiletype
    au BufRead,BufNewFile *ru setfiletype ruby
    au BufRead,BufNewFile Gemfile setfiletype ruby
    au BufRead,BufNewFile Guardfile setfiletype ruby
augroup end

augroup markdownfiletype
    au BufRead,BufNewFile *.markdown setfiletype markdown
    au BufRead,BufNewFile *.mkd setfiletype markdown
    au BufRead,BufNewFile *.md setfiletype markdown
augroup end

augroup sconsfiletype
    au BufRead,BufNewFile SConscript setfiletype python
    au BufRead,BufNewFile SConstruct setfiletype python
augroup end
