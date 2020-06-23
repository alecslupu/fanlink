# frozen_string_literal: true

class EmojiValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'may not contain emojis.') if emoji?(value)
  end

  private
  def emoji?(value)
    value =~ /[\uFE00-\uFE0F\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9-\u21AA\u231A-\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA-\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614-\u2615\u2618\u261D\u2620\u2622-\u2623\u2626\u262A\u262E-\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u2660\u2663\u2665-\u2666\u2668\u267B\u267E-\u267F\u2692-\u2697\u2699\u269B-\u269C\u26A0-\u26A1\u26AA-\u26AB\u26B0-\u26B1\u26BD-\u26BE\u26C4-\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3-\u26D4\u26E9-\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u2709\u270A-\u270B\u270C-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733-\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763-\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934-\u2935\u2B05-\u2B07\u2B1B-\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299\u{1F004}\u{1F0CF}\u{1F170}-\u{1F171}\u{1F17E}\u{1F17F}\u{1F18E}\u{1F191}-\u{1F19A}\u{1F1E6}-\u{1F1FF}\u{1F201}-\u{1F202}\u{1F21A}\u{1F22F}\u{1F232}-\u{1F23A}\u{1F250}-\u{1F251}\u{1F300}-\u{1F320}\u{1F321}\u{1F324}-\u{1F32C}\u{1F32D}-\u{1F32F}\u{1F330}-\u{1F335}\u{1F336}\u{1F337}-\u{1F37C}\u{1F37D}\u{1F37E}-\u{1F37F}\u{1F380}-\u{1F393}\u{1F396}-\u{1F397}\u{1F399}-\u{1F39B}\u{1F39E}-\u{1F39F}\u{1F3A0}-\u{1F3C4}\u{1F3C5}\u{1F3C6}-\u{1F3CA}\u{1F3CB}-\u{1F3CE}\u{1F3CF}-\u{1F3D3}\u{1F3D4}-\u{1F3DF}\u{1F3E0}-\u{1F3F0}\u{1F3F3}-\u{1F3F5}\u{1F3F7}\u{1F3F8}-\u{1F3FF}\u{1F400}-\u{1F43E}\u{1F43F}\u{1F440}\u{1F441}\u{1F442}-\u{1F4F7}\u{1F4F8}\u{1F4F9}-\u{1F4FC}\u{1F4FD}\u{1F4FF}\u{1F500}-\u{1F53D}\u{1F549}-\u{1F54A}\u{1F54B}-\u{1F54E}\u{1F550}-\u{1F567}\u{1F56F}-\u{1F570}\u{1F573}-\u{1F579}\u{1F57A}\u{1F587}\u{1F58A}-\u{1F58D}\u{1F590}\u{1F595}-\u{1F596}\u{1F5A4}\u{1F5A5}\u{1F5A8}\u{1F5B1}-\u{1F5B2}\u{1F5BC}\u{1F5C2}-\u{1F5C4}\u{1F5D1}-\u{1F5D3}\u{1F5DC}-\u{1F5DE}\u{1F5E1}\u{1F5E3}\u{1F5E8}\u{1F5EF}\u{1F5F3}\u{1F5FA}\u{1F5FB}-\u{1F5FF}\u{1F600}\u{1F601}-\u{1F610}\u{1F611}\u{1F612}-\u{1F614}\u{1F615}\u{1F616}\u{1F617}\u{1F618}\u{1F619}\u{1F61A}\u{1F61B}\u{1F61C}-\u{1F61E}\u{1F61F}\u{1F620}-\u{1F625}\u{1F626}-\u{1F627}\u{1F628}-\u{1F62B}\u{1F62C}\u{1F62D}\u{1F62E}-\u{1F62F}\u{1F630}-\u{1F633}\u{1F634}\u{1F635}-\u{1F640}\u{1F641}-\u{1F642}\u{1F643}-\u{1F644}\u{1F645}-\u{1F64F}\u{1F680}-\u{1F6C5}\u{1F6CB}-\u{1F6CF}\u{1F6D0}\u{1F6D1}-\u{1F6D2}\u{1F6E0}-\u{1F6E5}\u{1F6E9}\u{1F6EB}-\u{1F6EC}\u{1F6F0}\u{1F6F3}\u{1F6F4}-\u{1F6F6}\u{1F6F7}-\u{1F6F8}\u{1F6F9}\u{1F910}-\u{1F918}\u{1F919}-\u{1F91E}\u{1F91F}\u{1F920}-\u{1F927}\u{1F928}-\u{1F92F}\u{1F930}\u{1F931}-\u{1F932}\u{1F933}-\u{1F93A}\u{1F93C}-\u{1F93E}\u{1F940}-\u{1F945}\u{1F947}-\u{1F94B}\u{1F94C}\u{1F94D}-\u{1F94F}\u{1F950}-\u{1F95E}\u{1F95F}-\u{1F96B}\u{1F96C}-\u{1F970}\u{1F973}-\u{1F976}\u{1F97A}\u{1F97C}-\u{1F97F}\u{1F980}-\u{1F984}\u{1F985}-\u{1F991}\u{1F992}-\u{1F997}\u{1F998}-\u{1F9A2}\u{1F9B0}-\u{1F9B9}\u{1F9C0}\u{1F9C1}-\u{1F9C2}\u{1F9D0}-\u{1F9E6}\u{1F9E7}-\u{1F9FF}\u23E9-\u23EC\u23F0\u23F3\u25FD-\u25FE\u267F\u2693\u26A1\u26D4\u26EA\u26F2-\u26F3\u26F5\u26FA\u{1F201}\u{1F232}-\u{1F236}\u{1F238}-\u{1F23A}\u{1F3F4}\u{1F6CC}\u{1F3FB}-\u{1F3FF}\u26F9\u{1F385}\u{1F3C2}-\u{1F3C4}\u{1F3C7}\u{1F3CA}\u{1F3CB}-\u{1F3CC}\u{1F442}-\u{1F443}\u{1F446}-\u{1F450}\u{1F466}-\u{1F469}\u{1F46E}\u{1F470}-\u{1F478}\u{1F47C}\u{1F481}-\u{1F483}\u{1F485}-\u{1F487}\u{1F4AA}\u{1F574}-\u{1F575}\u{1F645}-\u{1F647}\u{1F64B}-\u{1F64F}\u{1F6A3}\u{1F6B4}-\u{1F6B6}\u{1F6C0}\u{1F918}\u{1F919}-\u{1F91C}\u{1F91E}\u{1F926}\u{1F933}-\u{1F939}\u{1F93D}-\u{1F93E}\u{1F9B5}-\u{1F9B6}\u{1F9D1}-\u{1F9DD}\u200D\u20E3\uFE0F\u{1F9B0}-\u{1F9B3}\u{E0020}-\u{E007F}\u2388\u2600-\u2605\u2607-\u2612\u2616-\u2617\u2619\u261A-\u266F\u2670-\u2671\u2672-\u267D\u2680-\u2689\u268A-\u2691\u2692-\u269C\u269D\u269E-\u269F\u26A2-\u26B1\u26B2\u26B3-\u26BC\u26BD-\u26BF\u26C0-\u26C3\u26C4-\u26CD\u26CF-\u26E1\u26E2\u26E3\u26E4-\u26E7\u26E8-\u26FF\u2700\u2701-\u2704\u270C-\u2712\u2763-\u2767\u{1F000}-\u{1F02B}\u{1F02C}-\u{1F02F}\u{1F030}-\u{1F093}\u{1F094}-\u{1F09F}\u{1F0A0}-\u{1F0AE}\u{1F0AF}-\u{1F0B0}\u{1F0B1}-\u{1F0BE}\u{1F0BF}\u{1F0C0}\u{1F0C1}-\u{1F0CF}\u{1F0D0}\u{1F0D1}-\u{1F0DF}\u{1F0E0}-\u{1F0F5}\u{1F0F6}-\u{1F0FF}\u{1F10D}-\u{1F10F}\u{1F12F}\u{1F16C}-\u{1F16F}\u{1F1AD}-\u{1F1E5}\u{1F203}-\u{1F20F}\u{1F23C}-\u{1F23F}\u{1F249}-\u{1F24F}\u{1F252}-\u{1F25F}\u{1F260}-\u{1F265}\u{1F266}-\u{1F2FF}\u{1F321}-\u{1F32C}\u{1F394}-\u{1F39F}\u{1F3F1}-\u{1F3F7}\u{1F3F8}-\u{1F3FA}\u{1F4FD}-\u{1F4FE}\u{1F53E}-\u{1F53F}\u{1F540}-\u{1F543}\u{1F544}-\u{1F54A}\u{1F54B}-\u{1F54F}\u{1F568}-\u{1F579}\u{1F57B}-\u{1F5A3}\u{1F5A5}-\u{1F5FA}\u{1F6C6}-\u{1F6CF}\u{1F6D3}-\u{1F6D4}\u{1F6D5}-\u{1F6DF}\u{1F6E0}-\u{1F6EC}\u{1F6ED}-\u{1F6EF}\u{1F6F0}-\u{1F6F3}\u{1F6F9}-\u{1F6FF}\u{1F774}-\u{1F77F}\u{1F7D5}-\u{1F7FF}\u{1F80C}-\u{1F80F}\u{1F848}-\u{1F84F}\u{1F85A}-\u{1F85F}\u{1F888}-\u{1F88F}\u{1F8AE}-\u{1F8FF}\u{1F900}-\u{1F90B}\u{1F90C}-\u{1F90F}\u{1F93F}\u{1F96C}-\u{1F97F}\u{1F998}-\u{1F9BF}\u{1F9C1}-\u{1F9CF}\u{1F9E7}-\u{1FFFD}]/x
  end
end
