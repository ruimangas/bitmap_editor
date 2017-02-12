module Helpers

  module Colors
    WHITE = 0
    GREEN = 'G'
    RED = 'R'
  end

  module Validations
    RULES = {
      'I' => '\A[I]{1} [0-9]{1} [0-9]{1}\Z',
      'L' => '\A[L]{1} [0-9]{1} [0-9]{1} [A-Z]{1}\Z',
      'V' => '\A[V]{1} [0-9]{1} [0-9]{1} [0-9]{1} [A-Z]{1}\Z',
      'H' => '\A[H]{1} [0-9]{1} [0-9]{1} [0-9]{1} [A-Z]{1}\Z',
      'C' => '\A[C]{1}\Z',
      'S' => '\A[S]{1}\Z',
      'X' => '\A[X]{1}\Z',
      '?' => '\A[?]{1}\Z'
    }
  end
end
