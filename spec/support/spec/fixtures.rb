# frozen_string_literal: true

def fixtures(*rest)
  File.join('spec', 'fixtures', *rest)
end
