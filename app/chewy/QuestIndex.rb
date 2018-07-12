class Questindex < Chewy::Index
  define_type Quest.includes(:steps) do
  end
end
