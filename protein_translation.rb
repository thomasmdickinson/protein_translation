require 'pry'

# Translation of condons and rna strands to protein.
class Translation
  TRANSLATION_TABLE = {
    'AUG' => 'Methionine',
    'UUU' => 'Phenylalanine', 'UUC' => 'Phenylalanine',
    'UUA' => 'Leucine', 'UUG' => 'Leucine',
    'UCU' => 'Serine', 'UCC' => 'Serine', 'UCA' => 'Serine', 'UCG' => 'Serine',
    'UAU' => 'Tyrosine', 'UAC' => 'Tyrosine',
    'UGU' => 'Cysteine', 'UGC' => 'Cysteine',
    'UGG' => 'Tryptophan',
    'UAA' => 'STOP', 'UAG' => 'STOP', 'UGA' => 'STOP'
  }

  def self.of_rna(str)
    tranlated = []
    split_codons(str).each do |codon|
      break if of_codon(codon) == 'STOP'
      tranlated << of_codon(codon)
    end
    tranlated
  end

  def self.split_codons(str)
    str.scan(/.../)
  end

  def self.of_codon(str)
    fail InvalidCodonError unless valid_codon?(str)
    TRANSLATION_TABLE[str] if valid_codon?(str)
  end

  def self.valid_codon?(str)
    TRANSLATION_TABLE.keys.include?(str.upcase)
  end
end

class InvalidCodonError < Exception
end
