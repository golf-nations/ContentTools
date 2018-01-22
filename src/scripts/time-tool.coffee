class TimeTool extends ContentTools.Tools.Unindent

  # Insert/Remove a <time> tag.

  # Register the tool with the toolshelf
  ContentTools.ToolShelf.stow(@, 'time')

  # The tooltip and icon modifier CSS class for the tool
  @label = 'Time'
  @icon = 'time'

  # The Bold provides a tagName attribute we can override to make inheriting
  # from the class cleaner.
  @tagName = 'time'

  @canApply: (element, selection) ->
# Return true if the tool can be applied to the current
# element/selection.
    return element.content

  @apply: (element, selection, callback) ->
  # Apply the tool to the specified element and selection

  # Store the selection state of the element so we can restore it once done
    element.storeState()

    @_galleryWindow = window.wp.media()
    @_galleryWindow.on 'select', (ev) =>

      selectedImage = @_galleryWindow.state().get('selection').first().toJSON()
      # availabe sizes (thumbnail, medium, large, full)
      mediumSizes = selectedImage.sizes.medium

#      cursor = selection.get()[0] + 1
#      slimEl = new ContentEdit.SlimImage('div', {class: 'slim', width: fullSize.width, height: fullSize.height}, '<img data-slim src="' + selectedImage.url + '">')
#      element.parent().attach(slimEl, 0)

      image = new ContentEdit.Image({src: selectedImage.url, width: mediumSizes.width, height: mediumSizes.height})
      element.parent().attach(image, 0)

#      selectedImage = @_galleryWindow.state().get('selection').first().toJSON()
#      cursor = selection.get()[0] + 1
#      tip = element.content.substring(0, selection.get()[0])
#      tail = element.content.substring(selection.get()[1])
#      image = new HTMLString.String('<img src="'+selectedImage.url+'" />', element.content.preserveWhitespace())
#      element.content = tip.concat(image, tail)
#      element.updateInnerHTML()
#      element.taint()

      selection.set(cursor, cursor)
      element.selection(selection)

    @_galleryWindow.open()


ContentTools.DEFAULT_TOOLS[0].push('time')