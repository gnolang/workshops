package microposts

import "gno.land/p/demo/ufmt"

func Render(_ string) string {
	out := "# Posts\n"
	for i := len(posts) - 1; i >= 0; i-- {
		out += ufmt.Sprintf("### Post #%d\n", i))
		out += posts[i].String()
	}
	return out
}

func (p Post) String() string {
	out := p.text + "\n"
	out += ufmt.Sprintf("_%s, by %s_\n",
		p.createdAt.Format("02 Jan 2006, 15:04"), p.author)
	return out
}
