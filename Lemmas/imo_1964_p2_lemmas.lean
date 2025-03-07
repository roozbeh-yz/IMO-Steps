import Mathlib
set_option linter.unusedVariables.analyzeTactics true

open Real

lemma imo_1964_p2_1
  (a b c : ℝ)
  (ha : 0 < -a + b + c)
  (hb : 0 < a - b + c)
  (hc : 0 < a + b - c)
  (g1 : (a + b - c) * (a - b + c) * (-a + b + c) ≤ a * b * c) :
  ((a + b - c) * (a - b + c) * (-a + b + c)) ^ 2 ≤ (a * b * c) ^ 2 := by
  refine pow_le_pow_left₀ (le_of_lt ?_) g1 2
  exact mul_pos (mul_pos hc hb) ha

lemma imo_1964_p2_2
  (a b c : ℝ) :
  (a + b - c) * (a + c - b) ≤ a ^ 2 := by
  have h₁: (a + b - c) * (a + c - b) = a ^ 2 - (b - c) ^ 2 := by
    linarith
  rw [h₁]
  refine sub_le_self _ ?_
  exact sq_nonneg (b - c)


lemma imo_1964_p2_3
  (a b c : ℝ) :
  a ^ 2 - (b - c) ^ 2 ≤ a ^ 2 := by
  simp
  exact sq_nonneg (b - c)


lemma imo_1964_p2_4
  (a b c : ℝ)
  (h₀ : 0 < a ∧ 0 < b ∧ 0 < c)
  (h₁ : c < a + b)
  (h₂ : b < a + c)
  (h₃ : a < b + c) :
  ((a + b - c) * (a + c - b) * (b + c - a)) ^ 2 ≤ (a * b * c) ^ 2 := by
  have ha : 0 < b + c - a := by exact sub_pos.mpr h₃
  have hb : 0 < a + c - b := by exact sub_pos.mpr h₂
  have hc : 0 < a + b - c := by exact sub_pos.mpr h₁
  have h₄₁: (a + b - c) * (a + c - b) ≤ a ^ 2 := by
    exact imo_1964_p2_2 a b c
  have h₄₂: (a + b - c) * (b + c - a) ≤ b ^ 2 := by
    rw [add_comm a b]
    exact imo_1964_p2_2 b a c
  have h₄₃: (a + c - b) * (b + c - a) ≤ c ^ 2 := by
    rw [add_comm a c, add_comm b c]
    exact imo_1964_p2_2 c a b
  have h₄₄: ((a + b - c) * (a + c - b) * (b + c - a)) ^ 2 = ((a + b - c) * (a + c - b)) *
      ((a + b - c) * (b + c - a)) * ((a + c - b) * (b + c - a)) := by
    linarith
  rw [h₄₄]
  repeat rw [mul_pow]
  refine mul_le_mul ?_ h₄₃ ?_ ?_
  . refine mul_le_mul h₄₁ h₄₂ ?_ ?_
    . refine le_of_lt ?_
      exact mul_pos hc ha
    . exact sq_nonneg a
  . refine le_of_lt ?_
    exact mul_pos hb ha
  . refine le_of_lt ?_
    simp_all only [sub_pos, gt_iff_lt, pow_pos, mul_pos_iff_of_pos_left]


lemma imo_1964_p2_5
  (a b c : ℝ)
  -- (h₀ : 0 < a ∧ 0 < b ∧ 0 < c)
  -- (h₁ : c < a + b)
  -- (h₂ : b < a + c)
  -- (h₃ : a < b + c)
  (ha : 0 < b + c - a)
  (hb : 0 < a + c - b)
  (hc : 0 < a + b - c)
  (h₄₁ : (a + b - c) * (a + c - b) ≤ a ^ 2)
  (h₄₂ : (a + b - c) * (b + c - a) ≤ b ^ 2)
  (h₄₃ : (a + c - b) * (b + c - a) ≤ c ^ 2) :
  ((a + b - c) * (a + c - b) * (b + c - a)) ^ 2 ≤ (a * b * c) ^ 2 := by
  repeat rw [mul_pow]
  rw [pow_two, pow_two, pow_two]
  have h₅: ((a + b - c) * (a + c - b)) * ((a + b - c) * (b + c - a)) ≤ a ^ 2 * b ^ 2 := by
    refine mul_le_mul h₄₁ h₄₂ ?_ ?_
    . refine le_of_lt ?_
      exact mul_pos hc ha
    . exact sq_nonneg a
  have h₆: ((a + b - c) * (a + c - b)) * ((a + b - c) * (b + c - a)) * ((a + c - b) * (b + c - a))
      ≤ a ^ 2 * b ^ 2 * c ^ 2 := by
    refine mul_le_mul h₅ h₄₃ ?_ ?_
    . refine le_of_lt ?_
      exact mul_pos hb ha
    . refine mul_nonneg ?_ ?_
      . exact sq_nonneg a
      . exact sq_nonneg b
  linarith


lemma imo_1964_p2_6
  (a b c : ℝ)
  -- (h₀ : 0 < a ∧ 0 < b ∧ 0 < c)
  -- h₁ : c < a + b
  -- h₂ : b < a + c
  -- h₃ : a < b + c
  (ha : 0 < b + c - a)
  (hb : 0 < a + c - b)
  (hc : 0 < a + b - c)
  (h₄₁ : (a + b - c) * (a + c - b) ≤ a ^ 2)
  (h₄₂ : (a + b - c) * (b + c - a) ≤ b ^ 2)
  (h₄₃ : (a + c - b) * (b + c - a) ≤ c ^ 2)
  (h₄₄ : ((a + b - c) * (a + c - b) * (b + c - a)) ^ 2 =
      (a + b - c) * (a + c - b) * ((a + b - c) * (b + c - a)) * ((a + c - b) * (b + c - a))) :
  ((a + b - c) * (a + c - b) * (b + c - a)) ^ 2 ≤ a ^ 2 * b ^ 2 * c ^ 2 := by
  rw [h₄₄]
  have h₅: ((a + b - c) * (a + c - b)) * ((a + b - c) * (b + c - a)) ≤ a ^ 2 * b ^ 2 := by
    refine mul_le_mul h₄₁ h₄₂ ?_ ?_
    . refine le_of_lt ?_
      exact mul_pos hc ha
    . exact sq_nonneg a
  have h₆: ((a + b - c) * (a + c - b)) * ((a + b - c) * (b + c - a)) * ((a + c - b) * (b + c - a))
      ≤ a ^ 2 * b ^ 2 * c ^ 2 := by
    refine mul_le_mul h₅ h₄₃ ?_ ?_
    . refine le_of_lt ?_
      exact mul_pos hb ha
    . refine mul_nonneg ?_ ?_
      . exact sq_nonneg a
      . exact sq_nonneg b
  linarith


lemma imo_1964_p2_7
  (a b c : ℝ)
  -- (h₀ : 0 < a ∧ 0 < b ∧ 0 < c)
  -- (h₁ : c < a + b)
  -- (h₂ : b < a + c)
  -- (h₃ : a < b + c)
  (ha : 0 < b + c - a)
  -- (hb : 0 < a + c - b)
  (hc : 0 < a + b - c)
  (h₄₁ : (a + b - c) * (a + c - b) ≤ a ^ 2)
  (h₄₂ : (a + b - c) * (b + c - a) ≤ b ^ 2) :
  -- (h₄₃ : (a + c - b) * (b + c - a) ≤ c ^ 2)
  -- (h₄₄ : ((a + b - c) * (a + c - b) * (b + c - a)) ^ 2 =
    -- (a + b - c) * (a + c - b) * ((a + b - c) * (b + c - a)) * ((a + c - b) * (b + c - a))) :
  (a + b - c) * (a + c - b) * ((a + b - c) * (b + c - a)) ≤ a ^ 2 * b ^ 2 := by
  refine mul_le_mul h₄₁ h₄₂ ?_ ?_
  . refine le_of_lt ?_
    exact mul_pos hc ha
  . exact sq_nonneg a


lemma imo_1964_p2_8
  (a b c : ℝ)
  (h₀ : 0 < a ∧ 0 < b ∧ 0 < c)
  -- (h₁ : c < a + b)
  -- (h₂ : b < a + c)
  -- (h₃ : a < b + c)
  -- (ha : 0 < b + c - a)
  -- (hb : 0 < a + c - b)
  -- (hc : 0 < a + b - c)
  (h₄ : ((a + b - c) * (a + c - b) * (b + c - a)) ^ 2 ≤ (a * b * c) ^ 2) :
  (a + b - c) * (a + c - b) * (b + c - a) ≤ a * b * c := by
  refine le_of_pow_le_pow_left₀ ?_ ?_ h₄
  . norm_num
  . refine le_of_lt ?_
    refine mul_pos ?_ h₀.2.2
    exact mul_pos h₀.1 h₀.2.1


lemma imo_1964_p2_9
  (a b c : ℝ)
  -- (h₀ : 0 < a ∧ 0 < b ∧ 0 < c)
  -- (h₁ : c < a + b)
  -- (h₂ : b < a + c)
  -- (h₃ : a < b + c)
  -- (ha : 0 < b + c - a)
  -- (hb : 0 < a + c - b)
  -- (hc : 0 < a + b - c)
  -- (h₄ : ((a + b - c) * (a + c - b) * (b + c - a)) ^ 2 ≤ (a * b * c) ^ 2)
  (h₅ : (a + b - c) * (a + c - b) * (b + c - a) ≤ a * b * c) :
  a ^ 2 * (b + c - a) + b ^ 2 * (c + a - b) + c ^ 2 * (a + b - c) ≤ 3 * a * b * c := by
  repeat rw [mul_sub]
  repeat rw [mul_add]
  linarith
