module Helpers

  module Colors
    WHITE = 'O'
    GREEN = 'G'
    RED = 'R'
  end

  module Validations
    # assumes that max bitmap size is 999X999
    RULES = {
      'I' => '\A[I]{1} \d{1,3} \d{1,3}\Z',
      'L' => '\A[L]{1} \d{1,3} \d{1,3} [A-Z]{1}\Z',
      'H' => '\A[H]{1} \d{1,3} \d{1,3} \d{1,3} [A-Z]{1}\Z',
      'V' => '\A[V]{1} \d{1,3} \d{1,3} \d{1,3} [A-Z]{1}\Z',
      'C' => '\A[C]{1}\Z',
      'S' => '\A[S]{1}\Z',
      'X' => '\A[X]{1}\Z',
      '?' => '\A[?]{1}\Z'
    }
  end
end
