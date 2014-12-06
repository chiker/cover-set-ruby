class AssertionError < RuntimeError
end

def assert &block
  raise AssertionError unless yield
end

def uniq_size str_arr
  str_arr.join('').split('').uniq.length
end

def cover_set acc, pool, uniq_len
  if uniq_size(acc)==uniq_len
    return acc, acc.length
  else
    pool.map do |s|
      new_acc = acc.dup
      new_pool = pool.dup
      new_acc << new_pool.delete(s)

      cover_set new_acc, new_pool, uniq_len
    end.min_by{|sub_set_res| sub_set_res.last}
  end
end

set = ['abc', 'abd', 'de']
assert {cover_set([], set, uniq_size(set)).first.length == 2}

set = ['abcg', 'abd', 'def', 'afg']
assert {cover_set([], set, uniq_size(set)).first.length == 2}
