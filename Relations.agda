{-# OPTIONS --universe-polymorphism #-}

open import Naturals
open import Functions
open import Logic

module Relations where



infix 11 _==_
data _==_ {n} {X : Set n} : X → X → Set n where
  refl : (x : X) → x == x

uneq-+-inl-inr : ∀ {n} {X Y : Set n} {x : X} {y : Y} → inl x == inr y → ⊥ {n}
uneq-+-inl-inr ()

uneq-+-inr-inl : ∀ {n} {X Y : Set n} {x : X} {y : Y} → inr x == inl y → ⊥ {n}
uneq-+-inr-inl ()

cong : ∀ {m n} {X : Set m} {Y : Set n} {x y : X} → (f : X → Y) → x == y → f x == f y
cong f (refl x) = refl (f x)

uncong-+-inl : ∀ {n} {X Y : Set n} {x y : X} → _==_ {n} {X + Y} (inl x) (inl y) → x == y
uncong-+-inl {_} {_} {_} {x} {.x} (refl .(inl x)) = refl x

uncong-+-inr : ∀ {n} {X Y : Set n} {x y : Y} → _==_ {X = X + Y} (inr x) (inr y) → x == y
uncong-+-inr {_} {_} {_} {x} {.x} (refl .(inr x)) = refl x

REL : ∀ {n} → Set n → Set n → (ℓ : ℕ) → Set (n ⊔ suc ℓ)
REL X Y ℓ = X → Y → Set ℓ

Rel : ∀ {n} → Set n → (ℓ : ℕ) → Set (n ⊔ suc ℓ)
Rel X ℓ = X → X → Set ℓ

Reflexive : ∀ {ℓ} {X : Set ℓ} → Rel X ℓ → Set _
Reflexive _~_ = ∀ {x} → x ~ x

Irreflexive : ∀ {ℓ} {X : Set ℓ} → Rel X ℓ → Set _
Irreflexive _~_ = ¬(Reflexive _~_)

Transitive : ∀ {ℓ} {X : Set ℓ} → Rel X ℓ → Set _
Transitive _~_ = ∀ {x y z} → (x ~ y) ∧ (y ~ z) → x ~ z

Asymmetric : ∀ {ℓ} {X : Set ℓ} → Rel X ℓ → Set _
Asymmetric _~_ = ∀ {x y} → ¬((x ~ y) ∧ (y ~ x))

Antisymmetric : ∀ {ℓ} {X : Set ℓ} → Rel X ℓ → Set _
Antisymmetric _~_ = ∀ {x y} → (x ~ y) ∧ (y ~ x) → x == y

Total : ∀ {ℓ} {X : Set ℓ} → Rel X ℓ → Set _
Total _~_ = ∀ {x y} → (x ~ y) ∨ (y ~ x)

Trichotomous : ∀ {ℓ} {X : Set ℓ} → Rel X ℓ → Set _
Trichotomous _~_ = ∀ {x y} → x ~ y ⊕ y ~ x ⊕ x == y

_⇒_ : ∀ {ℓ} {X Y : Set ℓ} → REL X Y ℓ → REL X Y ℓ → Set _
p ⇒ q = ∀ {x y} → p x y → q x y

_∩_ : ∀ {ℓ} {X Y : Set ℓ} → REL X Y ℓ → REL X Y ℓ → Set _
_∩_ {_} {X} {Y} p q = ∃ X (λ x → ∃ Y (λ y → p x y ∧ q x y))

_⇔_ : ∀ {ℓ} {X Y : Set ℓ} → REL X Y ℓ → REL X Y ℓ → Set _
p ⇔ q = (p ⇒ q) ∧ (q ⇒ p)

_⊞_ : ∀ {ℓ} {X Y : Set ℓ} → REL X Y ℓ → REL X Y ℓ → Set _
p ⊞ q = ∀ {x y} → p x y ⊕ q x y