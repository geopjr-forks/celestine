describe Celestine::Filter do
  it "should add a filter element" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.filter do |f|
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_filter?.should eq true
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end
    parser.free
  end

  make_filter_test(Celestine::Filter::Blur, blur)
  make_filter_test(Celestine::Filter::Offset, offset)
  make_filter_test(Celestine::Filter::Morphology, morphology)
  make_filter_test(Celestine::Filter::Merge, merge)

  it "should add a merge node filter element" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.filter do |f|
        f.merge do |b|
          b.add_node(Celestine::Filter::SOURCE_GRAPHIC)
          b 
        end
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_filter?.should eq true
        if child_element = child_element.child
          child_element.is_tag_femerge?.should eq true
          if child_element = child_element.child
            child_element.is_tag_femergenode?.should eq true
          else
            raise "no child"
          end
        else
          raise "no child"
        end
        else
          raise "no child"
        end
      else
        raise "no child"
      end
    end
    parser.free
  end
end